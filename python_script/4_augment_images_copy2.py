from PIL import Image
import os
import random
from common import get_input_folder, is_image_file, convert_to_rgb

# 현재 스크립트 파일이 위치한 디렉토리를 기준으로 루트 디렉토리 설정
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(
    os.path.join(script_dir, "..")
)  # 상위 디렉토리로 이동

# 사용자가 선택할 수 있는 폴더 목록
# 반드시 '_preprocessed' 가 붙어있는 전처리된 dataset을 선택해야 함!
input_folders = {
    "6": "_preprocessed_new_combine_data/train",  # 2번 데이터셋을 나눈 것 중 훈련셋만
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

# 모든 클래스 폴더의 이미지 수 계산
class_counts = {}
for class_folder in os.listdir(input_folder):
    class_path = os.path.join(input_folder, class_folder)
    if os.path.isdir(class_path):
        image_files = [
            f
            for f in os.listdir(class_path)
            if is_image_file(f) and not f.startswith("Aug_")
        ]
        class_counts[class_folder] = len(image_files)

# 데이터셋 클래스 중 가장 많은 이미지 수로 설정
max_count = max(class_counts.values())

# 각 클래스 폴더에 대해 증강 수행
for class_folder, count in class_counts.items():
    class_path = os.path.join(input_folder, class_folder)
    image_files = [
        f
        for f in os.listdir(class_path)
        if is_image_file(f) and not f.startswith("Aug_")
    ]
    images_needed = max_count - count

    if images_needed > 0:
        existing_images = [os.path.join(class_path, f) for f in image_files]
        for i in range(images_needed):
            original_image_path = random.choice(existing_images)
            try:
                with Image.open(original_image_path) as img:
                    img = convert_to_rgb(img)
                    aug_name, aug_func = random.choice(
                        list(augmentation_methods.items())
                    )
                    aug_img = aug_func(img)
                    base_name = os.path.splitext(
                        os.path.basename(original_image_path)
                    )[0]
                    aug_filename = f"Aug_bal_{i}_{base_name}.jpg"
                    aug_filepath = os.path.join(class_path, aug_filename)
                    aug_img.save(aug_filepath, format="JPEG")
                    print(f"증강 완료: {aug_filepath}")
            except Exception as e:
                print(f"Failed to process {original_image_path}: {e}")

# 증강 작업 완료 후 이미지 수 출력
for class_folder in class_counts.keys():
    class_path = os.path.join(input_folder, class_folder)
    original_images = [
        f
        for f in os.listdir(class_path)
        if is_image_file(f) and not f.startswith("Aug_")
    ]
    augmented_images = [
        f
        for f in os.listdir(class_path)
        if is_image_file(f) and f.startswith("Aug_")
    ]

    original_images_count = len(original_images)
    augmented_images_count = len(augmented_images)

    print(
        f"클래스 '{class_folder}': 원본 {original_images_count}개 + 증강 {augmented_images_count}개 = 총 {original_images_count + augmented_images_count}개"
    )

print(
    f"모든 증강 작업이 완료되었습니다. 결과는 {input_folder}에 저장되었습니다."
)
