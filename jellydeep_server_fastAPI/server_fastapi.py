import io
import uvicorn
from fastapi import FastAPI, HTTPException, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import logging
from PIL import Image
import numpy as np
import tensorflow as tf
from tensorflow.keras.layers import TFSMLayer

# FastAPI 앱 생성
app = FastAPI()

# CORS 설정
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 로깅 설정
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# 젤리피시 클래스 정의
jellyfish_classes = [
    "blue_jellyfish",
    "barrel_jellyfish",
    "compass_jellyfish",
    "lions_mane_jellyfish",
    "mauve_stinger_jellyfish",
    "Moon_jellyfish",
]

# TFSMLayer를 이용한 모델 로드
try:
    model = TFSMLayer("./_models/resnet18_no_opt", call_endpoint="serving_default")
    logger.info("TFSMLayer 모델 로드 성공")
except Exception as e:
    logger.error(f"모델 로드 실패: {e}")
    raise RuntimeError(f"모델 로드 실패: {e}")


def preprocess_image(image: Image.Image, target_size=(224, 224)):
    """
    이미지 전처리 함수. RGB 변환, 리사이즈, 정규화 수행.
    """
    try:
        # 이미지를 RGB로 변환
        image = image.convert("RGB")
        # 이미지 크기 조정
        image = image.resize(target_size)
        # 이미지 배열로 변환 및 정규화
        img_array = np.array(image, dtype=np.float32) / 255.0
        # 배치 차원 추가
        img_array = np.expand_dims(img_array, axis=0)
        return img_array
    except Exception as e:
        raise ValueError(f"이미지 전처리 실패: {e}")


def predict_image(image: Image.Image):
    """
    Perform model prediction on the preprocessed image.
    """
    try:
        # 이미지 전처리
        preprocessed_img = preprocess_image(image)
        logger.info(
            f"Preprocessed image shape: {preprocessed_img.shape}, dtype: {preprocessed_img.dtype}"
        )

        # 모델 예측 수행
        try:
            predictions = model(preprocessed_img, training=False)  # 모델 호출
            logger.info(f"Predictions dict keys: {predictions.keys()}")

            # 모델 출력 키 확인
            output_key = list(predictions.keys())[0]  # 첫 번째 키 사용
            outputs = predictions[output_key]  # 출력 값 가져오기
            logger.info(f"Model outputs: {outputs.numpy()}")

            # 확률화
            probabilities = tf.nn.softmax(outputs[0]).numpy()
        except Exception as prediction_error:
            logger.error(f"Model call failed: {prediction_error}")
            raise HTTPException(
                status_code=500, detail="Model prediction failed."
            )

        # 클래스 매핑
        class_probabilities = dict(
            zip(jellyfish_classes, probabilities.tolist())
        )
        logger.info(f"Final prediction: {class_probabilities}")

        return class_probabilities
    except Exception as e:
        logger.error(f"Prediction failed: {e}", exc_info=True)
        raise HTTPException(
            status_code=500, detail=f"Prediction failed: {str(e)}"
        )


# 루트 엔드포인트
@app.get("/")
async def read_root():
    logger.info("Root URL 요청됨")
    return "Welcome to the jellyfish classification API using TFSMLayer!"


@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    """
    업로드된 이미지에 대한 모델 예측 수행.
    """
    try:
        contents = await file.read()
        image = Image.open(io.BytesIO(contents)).convert("RGB")
        logger.info("이미지 업로드 성공.")
        # 예측 수행
        result = predict_image(image)
        return {"predictions": result}
    except Exception as e:
        logger.error(f"예측 실패: {e}")
        raise HTTPException(status_code=500, detail=str(e))


# 서버 실행
if __name__ == "__main__":
    uvicorn.run(
        "server_fastapi:app",
        reload=True,  # 코드 변경 시 자동 리로드
        host="127.0.0.1",  # 로컬호스트
        port=12530,  # 포트
        log_level="info",  # 로깅 레벨
    )
