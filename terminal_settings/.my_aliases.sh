unalias -a

################################################
# TEMPORARY
################################################
alias python="python3"

################################################
# Tips
################################################
# No need to use $MYHOME

################################################
# My Alias setting
################################################
# Search alias
alias al="alias"
# Search aliases
alias alg="alias | grep"
# View alias
alias all="alias | less"
# Edit alias
alias alv="vim $HOME/.my_aliases.sh"
# Update alias
alias als="source $HOME/.my_aliases.sh"

################################################
# Vim
################################################
alias vp="vim -p"
alias vpc="vim -p *.c"
alias vpac="vim -p */*.c"

alias vo="vim -o"
alias voc="vim -o *.c"
alias voac="vim -o */*.c"

alias vO="vim -O"
alias vOc="vim -O *.c"
alias vOac="vim -O */*.c"

################################################
# C / C++ Language
################################################
alias t="./_TEST.out"
# TEMPORARY
alias tt="./_libft_war_machine/grademe.sh"

alias cc="gcc -Wall -Wextra -g3 -fsanitize=address"
alias cca="cc *.c"
alias ccm="cc m.c"
alias ccat="cca -D TEST=1 -o _TEST.out && ./_TEST.out"
alias ccmt="ccm -D TEST=1 -o _TEST.out && ./_TEST.out"

alias gcca="gcc *.c"
alias gccm="gcc m.c"
alias gccat="gcc *.c -D TEST=1 -o _TEST.out && ./_TEST.out"
alias gccmt="gcc m.c -D TEST=1 -o _TEST.out && ./_TEST.out"

alias pp="clang++ -std=c++0x -Wall -Wextra"
alias ppa="pp *.cpp"
alias ppm="pp m.cpp"
alias ppat="ppa -D TEST=1 -o _TEST.out && ./_TEST.out"
alias ppmt="ppm -D TEST=1 -o _TEST.out && ./_TEST.out"

alias m="make"
alias mf="make fclean"
alias mc="make clean"
alias mr="make re"
alias mt="make test"

alias nn="~/.norminette/norminette.rb"
# alias nn2="norminette -R CheckForbiddenSourceHeader"
alias nnc="nn *.c"
alias nnac="nn */*.c"
alias nnac.="cd .. && nnac && cd -"

alias rmo="find . -maxdepth 1 -type f -name '*\.o*' -exec rm {} \;"
alias rmt="rm _TEST*"

################################################
# Directory / Files
################################################
alias duh="du -h"
alias duhm="du -h | grep '\d\d\dM\t'"
alias duhg="du -h | grep '[0-9]G\t'"

alias p="pwd"

alias ls="ls -G"
alias lsl="ls -lpA"
alias l="lsl"
alias lsa="ls -A"
alias lsA="ls -A *"

alias ~="cd ~"
alias .="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

################################################
# GIT
################################################
alias gs="git status"

alias ga="git add"
alias ga.="git add ."
alias gaa="git add --all"
# git add -p will interactively let you add, skip, or split diff hunks.
#
alias gap="git add -p"
# update: stage deleted / modified files
alias gau="git add -u"

alias gres="git reset"
alias gress="git reset --soft"
alias gresh="git reset --hard"

# git reflog
# ↓
# Ref: git reset --hard <commit_id>
alias grf="git reflog"
alias grf1="git reflog --format='%C(auto)%h %<|(18)%gd %C(blue)%cr%C(reset) %gs (%s)'"

alias gc="git commit"
alias gcm="git commit -m"

alias gcae="git commit --allow-empty"
alias gcaeic="gcae -m 'Initial commit'"

alias gca="git commit --amend"
alias gcam="git commit --amend -m"
alias gcaae="git commit --amend --allow-empty"

# amend staged files + update date with no edit
alias gcad="git commit --amend --no-edit --date=now"
# Ref: git commit --amend --date="Thr Jul 8 15:39 2021 +0900" --no-edit

alias gcp="git cherry-pick"

alias gl="git log"
alias glo="git log --oneline"
alias gla="git log --oneline --graph --all"

alias glr="git log --reverse"
alias glro="git log --reverse --oneline"
alias glra="git log --reverse --oneline --all"

alias gl1="git log --graph --all --abbrev-commit --date=format:'%y.%m.%d %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%ad %C(Green)<%an>%Creset %s %C(Red)%d'"
alias gl11="git log --graph --all --abbrev-commit --date=relative --pretty=format:'%C(Yellow)%h %C(Cyan)%ar %C(Green)<%an>%Creset %s %C(Red)%d'"
alias gl111="git log --graph --all --abbrev-commit --date=format:'%Y.%m.%d %H:%M %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%ad %C(Green)<%an>%Creset %s %C(Red)%d'"
alias gl2="git log --graph --all --abbrev-commit --date=format:'%y.%m.%d %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%cd %C(Green)<%cn>%Creset %s %C(Red)%d'"
alias gl22="git log --graph --all --abbrev-commit --date=relative --pretty=format:'%C(Yellow)%h %C(Cyan)%cr %C(Green)<%cn>%Creset %s %C(Red)%d'"
alias gl222="git log --graph --all --abbrev-commit --date=format:'%Y.%m.%d %H:%M %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%cd %C(Green)<%cn>%Creset %s %C(Red)%d'"

alias glr1="git log --reverse --all --abbrev-commit --date=format:'%y.%m.%d %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%ad %C(Green)<%an>%Creset %s %C(Red)%d'"
alias glr11="git log --reverse --all --abbrev-commit --date=relative --pretty=format:'%C(Yellow)%h %C(Cyan)%ar %C(Green)<%an>%Creset %s %C(Red)%d'"
alias glr111="git log --reverse --all --abbrev-commit --date=format:'%Y.%m.%d %H:%M %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%ad %C(Green)<%an>%Creset %s %C(Red)%d'"
alias glr2="git log --reverse --all --abbrev-commit --date=format:'%y.%m.%d %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%cd %C(Green)<%cn>%Creset %s %C(Red)%d'"
alias glr22="git log --reverse --all --abbrev-commit --date=relative --pretty=format:'%C(Yellow)%h %C(Cyan)%cr %C(Green)<%cn>%Creset %s %C(Red)%d'"
alias glr222="git log --reverse --all --abbrev-commit --date=format:'%Y.%m.%d %H:%M %a' --pretty=format:'%C(Yellow)%h %C(Cyan)%cd %C(Green)<%cn>%Creset %s %C(Red)%d'"

############
alias glsf='git ls-files'

############
alias gdf="git diff"           # Unstaged files
alias gdfs="git diff --staged" # Staged files
alias gdfn="git diff --name-status "
gdfg() {
	git diff -G"$1"
}
gdfh() {
	if [[ "$1" == "" ]]; then
		git diff HEAD
	else
		git diff HEAD~$1 HEAD
	fi
}
gdfsh() {
	if [[ "$1" == "" ]]; then
		git diff --staged HEAD
	else
		git diff --staged HEAD~$1
	fi
}

############
alias gcl="git clone"

alias gr="git remote"
alias gra="git remote add"
alias grao="git remote add origin"
alias grsu="git remote set-url"
alias grsuo="git remote set-url origin"
# Ref: git remote set-url origin git@github.com:username/repo.git
alias grr="git remote remove"
alias grro="git remote remove origin"

alias grm="git rm"
alias grmc="git rm --cached"
alias grmcr="git rm --cached -r"

alias grv="git remote -v"

alias gfc="git fetch"
alias gpl="git pull"

alias gps="git push"
alias gpso="git push origin"
alias gpsf="git push --force-with-lease"
alias gpsa="git push --all"
alias gpsao="git push --all origin"
alias gpsu="git push --set-upstream" # == -u
alias gpsuf="gpsu --force-with-lease"
alias gpsuo="gpsu origin"
# git push --set-upstream origin main
alias gpsuom="gpsuo main"
alias gpsufo="gpsuf origin"
alias gpsufom="gpsufo main"

############
# git subtree push --prefix dist origin gh-pages"
# Deploying a subfolder to GitHub Pages
alias gstpsp="git subtree push --prefix"

############
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcot="git checkout -t"
alias gcom="git checkout main"

alias gbr="git branch"

### Rename the local branch to the new name
# git branch -m <old_name> <new_name>
alias gbrm="git branch -m"

alias gbrd="git branch --delete"
### Delete the old branch on remote - where <remote> is, for example, origin
# git push <remote> --delete <old_name>
# git push <remote> :<old_name>
alias gpsod="git push origin --delete"

### Prevent git from using the old name when pushing in the next step.
### Otherwise, git will use the old upstream name instead of <new_name>.
# git branch --unset-upstream <old_name>

### Push the new branch to remote
# git push <remote> <new_name>

### Reset the upstream branch for the new_name local branch
# git push <remote> -u <new_name>

############
alias gmg="git merge"
alias gmga="git merge --abort"
alias gmgnf="git merge --no-ff"

############
alias glsf="git ls-files"

############
alias gt="git tag"
alias gtn="git tag -n"

# git tag -a v1.2.0
# git tag -a v1.2.0 -m "Clever release title"
# git tag -a v1.2.0 9fceb02 -m "Message here"
alias gta="git tag --annotate"

# git tag --delete v1.2.0
alias gtd="git tag --delete"

# git push origin :tagname
alias gpst="git push --tags"
# git push --delete origin tagname
alias gpsdo="git push --delete origin"

# Here is how I rename a tag old to new:
#
#   git tag new old
#   git tag -d old
#   git push origin :refs/tags/old
#   git push --tags
#
# The colon in the push command removes the tag from the remote repository. If  you don't do this, Git will create the old tag on your machine when you pull.
#
# Finally, make sure that the other users remove the deleted tag. Please tell  them (co-workers) to run the following command:
#
#   git pull --prune --tags
alias gplpt="git pull --prune --tags"

# If you only want those tags which exist on the remote, delete all your local tags:
#
#   $ git tag -d $(git tag)
#
# And then fetch all the remote tags:
#
#   $ git fetch --tags

############
# git show v1.4
alias gsw="git show"

alias gdc="git describe"

############
alias gsts="git stash"
alias gstsp="git stash pop"
alias gstsd="git stash drop"

############
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbir="git rebase -i --root"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"

############
alias gcf="git config"
alias gcfl="git config -l"
alias gcfge="git config --global --edit"

################################################
# Docker
################################################

alias dk="docker"

alias dki="docker image"
# == docker images
alias dkil="docker image ls"

alias dkps="dk ps"
alias dkpsa="dk ps -a"

alias dkst="dk stop"
alias dkrm="dk rm"
alias dkrmi="dk rmi"

# To stop all containers including its volumes use,
# docker stop -vf \$(docker ps -a -q)
alias dkstall="docker stop \$(docker ps -a -q)"

# To delete all containers including its volumes use,
# docker rm -vf \$(docker ps -a -q)
alias dkrmall="docker rm -vf \$(docker ps -a -q)"

# To delete all the images,
# docker rmi -f \$(docker images -a -q)
alias dkrmiall="docker rmi -f \$(docker images -a -q)"

# dk build srcs/mysql -t services-mysql
alias dkb="dk build"

alias dkc="dk container"
alias dkcr="dkc run"

alias dks="dk start"

alias dke="dk exec"

alias dksy="dk system"
alias dksyp="dksy prune"
alias dksypa="dksyp -a"

################################################
# Docker-Compose
################################################
alias dkc="docker-compose"

alias dkcu="dkc up"
alias dkcud="dkcu -d"

alias dkcs="dkc stop"

alias dkcd="dkc down"

alias dkcps="dkc ps"

alias dkcl="dkc logs"
alias dkclf="dkc logs -f"

################################################
# Kubernetes - Minikube / Kubectl
################################################
### Minikube
alias mk="minikube"

# @@T
mkst() {
	if [[ "$1" == "vb" ]]; then
		minikube start --driver=virtualbox
	elif [[ "$1" == "hk" ]]; then
		minikube start --driver=hyperkit
	else
		minikube start # default driver: docker
	fi
}

alias mkstat="mk status"
alias mkdel="mk delete"
alias mkdb="mk dashboard"

alias mkde="eval \$(minikube docker-env)"

### Kubectl
alias kc="kubectl"

alias kcc="kc create"
alias kccdp="kcc deployment"

# kc exec -it wordpress-5fd9b5b866-ngws8 -- /bin/sh
alias kce="kc exec -it"

alias kcg="kc get"
alias kcga="kcg all" # pod, replicaset, deployment, service

alias kcgao="kcga -o"
alias kcgaow="kcgao wide"
alias kcgaoy="kcgao yaml"
alias kcgaoj="kcgao json"
alias kcgaojq='kcgao json | jq ".items[] | {name:.metadata.name} + .status.capacity"'

alias kcgn="kcg nodes" # ==node ==no
alias kcgno="kcgn -o"
alias kcgnow="kcgno wide"
alias kcgnoy="kcgno yaml"
alias kcgnoj="kcgno json"
alias kcgnojq='kcgno json | jq ".items[] | {name:.metadata.name} + .status.capacity"'

alias kcgp="kcg pod"
alias kcgpo="kcgp -o"
alias kcgpow="kcgpo wide"
alias kcgpoy="kcgpo yaml"
alias kcgpoj="kcgpo json"
alias kcgpojq='kcgpo json | jq ".items[] | {name:.metadata.name} + .status.capacity"'

alias kcgrs="kcg replicaset"
alias kcgrso="kcgrs -o"
alias kcgrsow="kcgrso wide"
alias kcgrsoy="kcgrso yaml"
alias kcgrsoj="kcgrso json"
alias kcgrsojq='kcgrso json | jq ".items[] | {name:.metadata.name} + .status.capacity"'

alias kcgdp="kcg deployment"
alias kcgdpo="kcgdp -o"
alias kcgdpow="kcgdpo wide"
alias kcgdpoy="kcgdpo yaml"
alias kcgdpoj="kcgdpo json"
alias kcgdpojq='kcgdpo json | jq ".items[] | {name:.metadata.name} + .status.capacity"'

alias kcgsv="kcg service"

alias kcglb="kcg loadbalancer"
alias kcgig="kcg ingress"
alias kcgv="kcg volume"
alias kcgcm="kcg configmap"
alias kcgsc="kcg secret"
alias kcgns="kcg namespace"

alias kcar="kc api-resources"

alias kcdc="kc describe"

alias kcl="kc logs"

alias kcdl="kc delete"
alias kcdlf="kcdl -f"

alias kca="kc apply"
alias kcaf="kca -f"

alias kcsc="kc scale"

alias kcro="kc rollout"

# kc rollout restart deployment/mysql
kcror() {
	if [[ "$1" == "dp" ]]; then
		echo "kubectl rollout restart deployment/$2"
	else
		echo "kubectl rollout restart $1"
	fi
}

################################################
# Service
################################################
alias sv="service"
alias svn="service nginx"

################################################
# Linux
################################################
alias ai="sudo apt install -y"
alias ar="sudo apt remove -y"

################################################
# cd settings
################################################

# # doesn't work
# $ vartilde='~/'
# $ cd $vartilde
# -bash: cd: ~: No such file or directory
#
# # works
# $ varfullpath='/Users/recurvirostridae'
# $ cd $varfullpath
#
# # works
# $ varwithhome="$HOME"
# $ cd $varwithhome
#
# # How to change ~/ to $HOME/ in vim
# :%s/\~\//\$HOME\//g

# export ONE_DRIVE="blah..." is in .zshrc

###### WARNING!!! ######
# dev settings: backup all
alias dsba="zsh $HOME/_ALL_CODES/_Dev_Settings_Backup/BACKUP_ALL.sh"

# dev settings: apply all
alias dsaa="zsh $HOME/_ALL_CODES/_Dev_Settings_Backup/APPLY_ALL.sh"
########################

alias cddl="cd ~/Downloads"
alias cddk="cd ~/Desktop"
alias cdo="cd $ONE_DRIVE/"

alias cda="cd $HOME/_ALL_CODES"
alias cdaf="cd $HOME/_ALL_CODES/AIFFEL_quest_cr"

alias cds="cd $HOME/_ALL_CODES/_Study_Notes"

alias cddsb="cd $HOME/_ALL_CODES/_Dev_Settings_Backup"
alias cddsbt="cd $HOME/_ALL_CODES/_Dev_Settings_Backup/terminal_settings"

alias cdp="cd $HOME/_ALL_CODES/_PLAYGROUND_for_each_IDE"
alias cdpp="cd $HOME/_ALL_CODES/_PLAYGROUND_for_each_IDE/Pycharm"

alias cd1="cd $HOME/_ALL_CODES/AIFFEL_quest_cr"
alias cd2="cd $HOME/_ALL_CODES/_Dev_Settings_Backup"



################################################
# Android Studio
################################################
alias opas="open -a /Applications/Android\ Studio.app"

################################################
# Brew
################################################
alias br="brew"
alias bri="brew install"
alias bru="brew upgrade"

################################################
# Shell Commands
################################################
alias c="clear"
