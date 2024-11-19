import os
import shutil, random
from PIL import Image
from common import get_project_root, get_input_folder, is_image_file, convert_to_rgb

# 사용자가 선택할 수 있는 폴더 목록
input_folders = {
    "6": "new_combine_data/",
}

# 폴더 설정
# 입력 폴더 경로 지정 및 받아오기
input_folder = get_input_folder(input_folders)

# 출력 폴더 경로 지정
output_folder = os.path.join( 
    get_project_root(),
    f"_preprocessed_{os.path.basename(input_folder.strip('/'))}",
)
os.makedirs(output_folder, exist_ok=True)  # 지정된 폴더가 없다면 mkdir로 생성

target_size = (224, 224)  # 목표 이미지 크기

# 입력 폴더 유효성 검사
if not os.path.exists(input_folder):
    raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

# 이미지 파일 처리
for root, _, files in os.walk(input_folder):  # os.walk() 폴더 내의 모든 파일 탐색
    for filename in files:
        # 파일명(확장자)을 확인하여 이미지 파일인지 확인
        if is_image_file(filename) or filename.lower().endswith(('.jfif', '.jpg', '.jpeg', '.png', 'JPG')):  
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
                    output_filepath = os.path.join(new_folder_path, new_filename)
                    
                    count = 1
                    while os.path.exists(output_filepath):
                        new_filename = f"{os.path.splitext(filename)[0]}_{count}.jpg"
                        output_filepath = os.path.join(new_folder_path, new_filename)
                        count += 1
                        
                    img.save(output_filepath, format="JPEG")  # 이미지 확장자명을 .jpeg로 변환
                    print(f"전처리 후 저장 완료: {output_filepath}")
            except Exception as e:
                print(f"Failed to process {filepath}: {e}")
                
# 확장자명 바꾸고 이미지 크기 조정하는 등 파일 처리를 다 했으니
# 각 클래스별 이미지 수를 아래 비율로 나눌 것
# 비율 = train:valid:test (6:2:2)
# _preprocessed_...폴더 아래 train, valid, test 폴더를 만들고
# 각 폴더 안에 이미지를 비율에 따라 클래스 별로 저장할 것

# train, valid, test 폴더 생성
train_folder = os.path.join(output_folder, "train")
valid_folder = os.path.join(output_folder, "valid")
test_folder = os.path.join(output_folder, "test")

os.makedirs(train_folder, exist_ok=True)
os.makedirs(valid_folder, exist_ok=True)
os.makedirs(test_folder, exist_ok=True)

# 전처리된 이미지들을 클래스 별로 분류하고 나누기
for class_folder in os.listdir(output_folder):
    class_folder_path = os.path.join(output_folder, class_folder)
    if not os.path.isdir(class_folder_path) or class_folder in ["train", "valid", "test"]:
        continue

    # 현재 클래스의 이미지 파일들 목록 가져오기
    image_files = [
        f for f in os.listdir(class_folder_path)
        if is_image_file(f)
    ]

    # 이미지 파일 순서를 랜덤으로 섞기
    random.shuffle(image_files)

    # 각 클래스별로 100장씩 valid, test로 나누고 나머지는 train으로
    valid_count = min(100, len(image_files))
    test_count = min(100, len(image_files) - valid_count)

    # 파일을 train, valid, test 폴더에 나누어 저장
    for idx, filename in enumerate(image_files):
        source_path = os.path.join(class_folder_path, filename)

        if idx < valid_count:
            target_folder = valid_folder
        elif idx < valid_count + test_count:
            target_folder = test_folder
        else:
            target_folder = train_folder

        class_target_folder = os.path.join(target_folder, class_folder)
        os.makedirs(class_target_folder, exist_ok=True)

        target_path = os.path.join(class_target_folder, filename)
        shutil.move(source_path, target_path)  # 파일 복사
        print(f"파일 이동: {source_path} -> {target_path}")

print("이미지 분할 및 이동 완료.")