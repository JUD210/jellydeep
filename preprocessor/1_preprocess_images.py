from PIL import Image
import os

# 현재 스크립트 파일이 위치한 디렉토리를 기준으로 루트 디렉토리 설정
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(
    os.path.join(script_dir, "..")
)  # 상위 디렉토리로 이동

# 사용자가 선택할 수 있는 폴더 목록
input_folders = {
    "1": "datasets_origin/",  # Kaggle 다운로드 후 압축 푼 폴더
    "2": "datasets_del_aug_duplicate/",  # 1번에서 중복 및 강화된 이미지 제거
    # TODO: 나중에 3,4,5도 사용하게 된다면, 1번이 아닌 2번 기준으로 작업해야 함.
    "3": "datasets_no_watermark/",  # 2번에서 워터마크 제거
    "4": "datasets_no_group,/",  # 2번에서 집단 해파리 이미지 제거
    "5": "datasets_no_obstacle/",  # 2번에서 방해물 제거
}

# 사용자 입력 받기
print("다음 중 변환할 폴더를 선택하세요:")
for key, path in input_folders.items():
    print(f"{key}. {path}")

user_choice = input("번호를 입력하세요: ")
if user_choice not in input_folders:
    raise ValueError("잘못된 선택입니다. 1에서 5 사이의 번호를 입력해주세요.")

# 입력 폴더의 절대 경로 설정
input_folder = os.path.join(project_root, input_folders[user_choice].strip("/"))

# 출력 폴더의 절대 경로 설정
output_folder = os.path.join(
    project_root,
    f"_preprocessed_{os.path.basename(input_folders[user_choice].strip('/'))}",
)
os.makedirs(output_folder, exist_ok=True)

# 이미지 크기 설정 (ImageNet 표준 사이즈)
target_size = (224, 224)

# input_folder가 존재하는지 확인
if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

# 이미지 전처리 및 형식 변환 (하위 폴더 포함)
for root, _, files in os.walk(input_folder):
    for filename in files:
        # 확장자 확인 및 이미지 파일 필터링
        if filename.lower().endswith((".jpeg", ".png", ".jpg")):
            filepath = os.path.join(root, filename)

            try:
                # 이미지 열기
                with Image.open(filepath) as img:
                    # RGB로 변환하여 채널 통일 (PNG의 경우 RGBA일 수 있음)
                    img = img.convert("RGB")

                    # 이미지 크기가 target_size가 아니면 조정
                    if img.size != target_size:
                        img = img.resize(target_size)

                    # 원본 폴더 구조 유지
                    relative_path = os.path.relpath(root, input_folder)
                    new_folder_path = os.path.join(output_folder, relative_path)
                    os.makedirs(new_folder_path, exist_ok=True)

                    # 파일명에서 확장자 제거 후 .jpg로 저장 경로 지정
                    new_filename = os.path.splitext(filename)[0] + ".jpg"
                    output_filepath = os.path.join(
                        new_folder_path, new_filename
                    )

                    # JPEG 형식으로 안전하게 저장
                    img.save(output_filepath, format="JPEG")
                    print(f"전처리 후 저장 완료: {output_filepath}")

            except Exception as e:
                print(f"Failed to process {filepath}: {e}")
