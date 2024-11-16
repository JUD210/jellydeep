from PIL import Image
import os
from common import get_project_root, get_input_folder, is_image_file, convert_to_rgb

# 사용자가 선택할 수 있는 폴더 목록
input_folders = {
    "1": "datasets_origin/",
    "2": "datasets_del_aug_duplicate/",
    # TODO: 나중에 3,4,5도 사용하게 된다면, 1번이 아닌 2번 기준으로 작업해야 함.
    "3": "datasets_no_watermark/",
    "4": "datasets_no_multi/",
    "5": "datasets_no_obstacle/",
}

input_folder = get_input_folder(input_folders)
output_folder = os.path.join(
    get_project_root(),
    f"_preprocessed_{os.path.basename(input_folder.strip('/'))}",
)
os.makedirs(output_folder, exist_ok=True)

target_size = (224, 224)

if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

for root, _, files in os.walk(input_folder):
    for filename in files:
        if is_image_file(filename):
            filepath = os.path.join(root, filename)
            try:
                with Image.open(filepath) as img:
                    img = convert_to_rgb(img)
                    if img.size != target_size:
                        img = img.resize(target_size)
                    relative_path = os.path.relpath(root, input_folder)
                    new_folder_path = os.path.join(output_folder, relative_path)
                    os.makedirs(new_folder_path, exist_ok=True)
                    new_filename = os.path.splitext(filename)[0] + ".jpg"
                    output_filepath = os.path.join(
                        new_folder_path, new_filename
                    )
                    img.save(output_filepath, format="JPEG")
                    print(f"전처리 후 저장 완료: {output_filepath}")
            except Exception as e:
                print(f"Failed to process {filepath}: {e}")
