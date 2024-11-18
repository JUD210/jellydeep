from PIL import Image
import os
import shutil  # shutil을 import하여 디렉토리 삭제에 사용
from common import (
    get_project_root,
    get_input_folder,
    is_image_file,
    convert_to_rgb,
)

# 사용자가 선택할 수 있는 폴더 목록
input_folders = {
    "1": "datasets_origin/",
    "2": "datasets_del_aug_duplicate/",
    # TODO: 나중에 3,4,5도 사용하게 된다면, 1번이 아닌 2번 기준으로 작업해야 함.
    "3": "datasets_no_watermark/",
    "4": "datasets_no_multi/",
    "5": "datasets_no_obstacle/",
}

# 폴더 설정
# 입력 폴더 경로 지정 및 받아오기
input_folder = get_input_folder(input_folders)

# 출력 폴더 경로 지정
output_folder = os.path.join(
    get_project_root(),
    f"_preprocessed_{os.path.basename(input_folder.strip('/'))}",
)

# 출력 폴더 삭제 후 재생성
if os.path.exists(output_folder):
    shutil.rmtree(output_folder)  # 기존 폴더 및 하위 파일 삭제
os.makedirs(output_folder, exist_ok=True)  # 새로운 폴더 생성

target_size = (224, 224)  # 목표 이미지 크기

# 입력 폴더 유효성 검사
if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

# 이미지 파일 처리
for root, _, files in os.walk(
    input_folder
):  # os.walk() 폴더 내의 모든 파일 탐색
    for filename in files:
        if is_image_file(
            filename
        ):  # 파일명(확장자)을 확인하여 이미지 파일인지 확인
            filepath = os.path.join(root, filename)
            try:
                with Image.open(filepath) as img:
                    img = convert_to_rgb(img)  # 이미지를 RGB형식으로 변환
                    if img.size != target_size:
                        img = img.resize(target_size)
                    relative_path = os.path.relpath(root, input_folder)
                    new_folder_path = os.path.join(output_folder, relative_path)
                    os.makedirs(new_folder_path, exist_ok=True)
                    new_filename = os.path.splitext(filename)[0] + ".jpg"
                    output_filepath = os.path.join(
                        new_folder_path, new_filename
                    )
                    img.save(
                        output_filepath, format="JPEG"
                    )  # 이미지 확장자명을 .jpeg로 변환
                    print(f"전처리 후 저장 완료: {output_filepath}")
            except Exception as e:
                print(f"Failed to process {filepath}: {e}")
