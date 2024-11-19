# How to use server_fastapi.py

## 1. FastAPI 서버 실행

1. **모델 경로 수정**
   `server_fastapi.py` 파일에서 `model_path` 값을 사용할 모델 경로로 수정.

2. **서버 실행**
    - 터미널에서 다음 명령어로 서버 실행:

    ```bash
    python3 server_fastapi.py
    ```

    - **백그라운드 실행 및 로그 저장**
    백그라운드에서 실행하고 로그를 저장하려면:

    ```bash
    nohup python3 server_fastapi.py >> _server_fastapi.log &
    ```

## 2. 로컬 컴퓨터에서 서버 실행 시 (외부 접근 설정)

- 로컬에서 서버를 실행할 경우 **Ngrok**으로 외부 접근 설정을 추가.
