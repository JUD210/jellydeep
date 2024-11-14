#!/bin/bash

# 1. zsh 설치 확인 및 설치
echo "[1] Checking if zsh is installed..."
if ! command -v zsh &>/dev/null; then
    echo "zsh is not installed. Installing zsh..."
    if [[ $(uname) == "Darwin" ]]; then
        brew install zsh
    else
        sudo apt-get update && sudo apt-get install zsh -y
    fi
else
    echo "zsh is already installed."
fi

# 2. less 설치 확인 및 설치
echo "[2] Checking if less is installed..."
if ! command -v less &>/dev/null; then
    echo "less is not installed. Installing less..."
    if [[ $(uname) == "Darwin" ]]; then
        brew install less
    else
        sudo apt-get install less -y
    fi
else
    echo "less is already installed."
fi

# 3. Oh My Zsh 설치 확인 및 설치
echo "[3] Checking if Oh My Zsh is installed..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# 4. Powerlevel10k 테마 설치 확인 및 설치
echo "[4] Checking if Powerlevel10k is installed..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Powerlevel10k is not installed. Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Powerlevel10k is already installed."
fi

# 5. .zshrc 설정 업데이트
echo "[5] Configuring .zshrc to use Powerlevel10k..."
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

# 6. 파일을 홈 디렉토리로 심볼릭 링크 생성
echo "[6] Creating symbolic links for configuration files in home directory..."

FILES=(.gitconfig .my_aliases.sh .vimrc .zshrc)
for FILE in "${FILES[@]}"; do
    if [ -f "$FILE" ]; then
        if [ -e "$HOME/$FILE" ]; then
            echo "$HOME/$FILE already exists. Removing existing file or link."
            rm -f "$HOME/$FILE" # 기존 파일이나 링크 삭제
        fi
        ln -s "$(pwd)/$FILE" "$HOME/$FILE"
        echo "Symbolic link for $FILE created in home directory."
    else
        echo "$FILE not found in the current directory."
    fi
done

# 7. 기본 쉘을 zsh로 설정
echo "[7] Setting zsh as the default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    echo "zsh has been set as the default shell."
else
    echo "zsh is already the default shell."
fi

echo "[8] Installation and setup complete. Please restart your terminal or open a new terminal session."
