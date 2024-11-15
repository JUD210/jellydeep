
import os

def get_project_root():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, ".."))
    return project_root

def get_input_folder(input_folders):
    print("다음 중 작업을 수행할 폴더를 선택하세요:")
    for key, path in input_folders.items():
        print(f"{key}. {path}")

    user_choice = input("번호를 입력하세요: ")
    if user_choice not in input_folders:
        raise ValueError("잘못된 선택입니다. 올바른 번호를 입력해주세요.")

    project_root = get_project_root()
    input_folder = os.path.join(project_root, input_folders[user_choice].strip("/"))

    if not os.path.exists(input_folder):
        raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

    return input_folder

def is_image_file(filename):
    return filename.lower().endswith((".jpeg", ".png", ".jpg"))

def convert_to_rgb(img):
    return img.convert("RGB")