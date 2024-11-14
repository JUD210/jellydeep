# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ "$(command -v python3)" != "" ]]; then
	alias py="python3"
elif [[ "$(command -v python)" != "" ]]; then
	alias py="python"
elif [[ "$(command -v python2)" != "" ]]; then
	alias py="python2"
fi


# Print all PATHs
py -c "
import os
import sys

if sys.platform == 'win32':
	splitter = ';'
else:
	splitter = ':'

paths = os.environ['PATH'].split(splitter)

print('<<<<<<<<< paths start <<<<<<<<<')

for i, l in enumerate(paths):
	print('[{:02d}]'.format(i) + l)

print('>>>>>>>>> paths end >>>>>>>>>')
"

echo "OSTYPE: $OSTYPE"
echo "NAME: $(hostname)"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    ip=$(hostname -I | sed s"/[0-9.]*/\0 |/g" | sed s"/ |  |//")
	echo "IP: $ip"

    if [[ "$(whoami)" == "hyuk_ubuntu" ]]; then
        export ONE_DRIVE="/mnt/d/OneDrive"
    fi

elif [[ "$OSTYPE" == darwin* ]]; then
    ip=$(ifconfig en0 | grep 'inet ' | awk '{print $2}')
    echo "IP: $ip"

    if [[ "$(whoami)" == "jud210" ]]; then
		export ONE_DRIVE="~/OneDrive/"
    fi

    export PATH="/usr/sbin:$PATH"
    export PATH="/sbin:$PATH"
    export PATH="$HOME/Developments/flutter/bin:$PATH"

	# Ruby
    export GEM_HOME=$HOME/.gem
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export PATH=$GEM_HOME/bin:$PATH

	# Java
    export JAVA_HOME="$(/usr/libexec/java_home)"

    # Brew install openjdk
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
    export CPPFLAGS="-I/usr/local/opt/openjdk/include"

elif [[ "$OSTYPE" == "msys" ]]; then
    # Git Bash //Win10
    # My Win10 Computer
    ip=$(ipconfig | grep IPv4 | sed s"/.*: //g" | awk 1 ORS=' | ' | sed s"/ | $//g")
    echo "$ip"

    if [[ "$(hostname)" == "DESKTOP-JM0COM2" ]]; then
        # Desktop
        export ONE_DRIVE="d:/OneDrive"
    elif [[ "$(hostname)" == "DESKTOP-6QHD9DP" ]]; then
        # Laptop
        export ONE_DRIVE="c:/Users/judic/OneDrive"
    fi

elif [[ "$OSTYPE" == "linux-android" ]]; then
    # Android //Termux (No rooting)
    # My Android Phone
    ip=$(hostname -I | sed s"/[0-9.]*/\0 |/g" | sed s"/ |  |//")
    echo "$ip"

    # To prevent Unknown AVD name Error
    export ANDROID_AVD_HOME=$HOME/.android/avd/

else
    echo "!!! WARNING !!!"
    echo "This is an unexpected situation! ($OSTYPE / $(hostname))"
fi


# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew
# mkdir $HOME/.linuxbrew/bin
# ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin
# eval $($HOME/.linuxbrew/bin/brew shellenv)

##############################################################################

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $HOME/.oh-my-zsh/plugins/*
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# export PAGER="most" //color manual
export PAGER="less"

# Disable default aliases made by oh-my-zsh.sh
unalias -a

source $HOME/.my_aliases.sh


# delete duplicated PATH
PATH=$(echo $PATH | awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh


# 가상환경 자동 활성화 및 경로 출력
if [ -d "$HOME/_ALL_CODES/_venv_py" ]; then
    if [ -z "$VIRTUAL_ENV" ]; then  # 가상환경이 활성화되지 않은 경우에만 활성화
        source $HOME/_ALL_CODES/_venv_py/bin/activate
        echo "Python3 Virtual environment activated. ($(basename $VIRTUAL_ENV))"

        # Python과 pip 경로 출력
        echo "Python path: $(which python3)"
        echo "pip path: $(which pip)"
    fi
else
    echo "Python3 Virtual environment is not activated."

    # 시스템의 Python과 pip 경로 출력
    echo "System Python path: $(which python3)"
    echo "System pip path: $(which pip)"
fi

################################################################################
############### Backup of Oh-My-Zsh Commentary
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
###### export ZSH="/Users/hmin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
###### ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $HOME/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $HOME/.oh-my-zsh/plugins/*
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
###### plugins=(git)

###### source $ZSH/oh-my-zsh.sh

# Disable default aliases made by oh-my-zsh.sh
###### unalias -m "*"

# Path to add vscode command (ex: code .)
###### alias code="$HOME/Downloads/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

###### source $HOME/.my_aliases.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#	export EDITOR='vim'
# else
#	export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2024-08-22 05:48:00
export PATH="$PATH:/Users/jud210/.local/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
