from PIL import Image
import os

# 현재 스크립트 파일이 위치한 디렉토리를 기준으로 경로 설정
script_dir = os.path.dirname(os.path.abspath(__file__))  # 스크립트 파일의 절대 경로
input_folder = os.path.join(script_dir, '../datasets_origin/')      # 원본 이미지 폴더
output_folder = os.path.join(script_dir, '../_preprocessed_datasets/') # 변환된 이미지 저장 폴더
os.makedirs(output_folder, exist_ok=True)  # 저장 폴더가 없으면 생성

# 이미지 크기 설정 (ImageNet 표준 사이즈)
target_size = (224, 224)

# input_folder가 존재하는지 확인
if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

# 이미지 전처리 및 형식 변환 (하위 폴더 포함)
for root, _, files in os.walk(input_folder):  # os.walk로 하위 폴더까지 탐색
    for filename in files:
        # 확장자 확인 및 이미지 파일 필터링
        if filename.lower().endswith(('.jpeg', '.png', '.jpg')):
            filepath = os.path.join(root, filename)

            try:
                # 이미지 열기
                with Image.open(filepath) as img:
                    # RGB로 변환하여 채널 통일 (PNG의 경우 RGBA일 수 있음)
                    img = img.convert("RGB")

                    # 이미지 크기 조정 (224x224)
                    img = img.resize(target_size)

                    # 파일명에서 확장자 제거 후 .jpg로 저장 경로 지정
                    # 원본 폴더 구조 유지
                    relative_path = os.path.relpath(root, input_folder)  # input_folder 기준 상대 경로
                    new_folder_path = os.path.join(output_folder, relative_path)
                    os.makedirs(new_folder_path, exist_ok=True)  # 상대 경로에 해당하는 폴더 생성

                    new_filename = os.path.splitext(filename)[0] + '.jpg'
                    output_filepath = os.path.join(new_folder_path, new_filename)

                    # 저장 경로 확인용 출력 (디버깅용)
                    print(f"Attempting to save file to: {output_filepath}")

                    # JPEG 형식으로 안전하게 저장
                    img.save(output_filepath, format="JPEG")
                    print(f"Processed and saved: {output_filepath}")

            except Exception as e:
                print(f"Failed to process {filename}: {e}")
