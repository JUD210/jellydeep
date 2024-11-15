from PIL import Image
import os
import random
from common import get_project_root, get_input_folder, is_image_file, convert_to_rgb

# 현재 스크립트 파일이 위치한 디렉토리를 기준으로 루트 디렉토리 설정
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(
    os.path.join(script_dir, "..")
)  # 상위 디렉토리로 이동

# 사용자가 선택할 수 있는 폴더 목록
# 반드시 '_preprocessed' 가 붙어있는 전처리된 dataset을 선택해야 함!
input_folders = {
    "1": "_preprocessed_datasets_origin/",  # Kaggle 다운로드 후 압축 푼 폴더
    "2": "_preprocessed_datasets_del_aug_duplicate/",  # 1번에서 중복 및 강화된 이미지 제거
    "3": "_preprocessed_datasets_no_watermark/",  # 2번에서 워터마크 제거
    "4": "_preprocessed_datasets_no_group/",  # 2번에서 집단 해파리 이미지 제거
    "5": "_preprocessed_datasets_no_obstacle/",  # 2번에서 방해물 제거
}

input_folder = get_input_folder(input_folders)

# input_folder가 존재하는지 확인
if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")


# 증강 함수 정의
def move(img):
    x_shift = random.randint(-10, 10)  # 이동할 픽셀 범위
    y_shift = random.randint(-10, 10)
    return img.transform(img.size, Image.AFFINE, (1, 0, x_shift, 0, 1, y_shift))


def zoom(img):
    zoom_factor = random.uniform(0.8, 1.2)  # 확대/축소 비율
    w, h = img.size
    img = img.resize((int(w * zoom_factor), int(h * zoom_factor)))
    return img.crop((0, 0, w, h))


def crop(img):
    w, h = img.size
    crop_size = random.randint(20, 50)
    return img.crop((crop_size, crop_size, w - crop_size, h - crop_size))


def rotate(img):
    angle = random.randint(-15, 15)  # 회전 각도
    return img.rotate(angle, expand=True)


# 증강 방법 매핑
augmentation_methods = {
    "move": move,
    "zoom": zoom,
    "crop": crop,
    "rotate": rotate,
}

# 이미지 증강 실행
for root, _, files in os.walk(input_folder):
    for filename in files:
        if is_image_file(filename) and not filename.startswith("Aug_"):
            filepath = os.path.join(root, filename)

            try:
                # 이미지 열기
                with Image.open(filepath) as img:
                    img = convert_to_rgb(img)  # RGB로 변환하여 채널 통일

                    # 원본 이미지 이름에서 확장자 제거
                    base_name = os.path.splitext(filename)[0]

                    # 각 증강 방법에 대해 새로운 이미지 생성
                    for aug_name, aug_func in augmentation_methods.items():
                        aug_img = aug_func(img)  # 증강 함수 실행
                        aug_filename = f"Aug_{aug_name}_{base_name}.jpg"  # 증강 이미지 파일명 생성
                        aug_filepath = os.path.join(
                            root, aug_filename
                        )  # 입력 폴더에 저장
                        aug_img.save(
                            aug_filepath, format="JPEG"
                        )  # JPEG 형식으로 저장
                        print(f"증강 완료: {aug_filepath}")

            except Exception as e:
                print(f"Failed to process {filepath}: {e}")

print(
    f"모든 증강 작업이 완료되었습니다. 결과는 {input_folder}에 저장되었습니다."
)
