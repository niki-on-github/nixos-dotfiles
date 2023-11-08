# zsh alias

alias zsh-vim="export ZSH_KEYMAP=\"vim\"; source ${ZDOTDIR:-$HOME}/.zshrc"
alias zsh-emacs="export ZSH_KEYMAP=\"emacs\"; source ${ZDOTDIR:-$HOME}/.zshrc"
alias vim="nvim" vimdiff="nvim -d" vi="nvim" v="nvim"
alias dolphin="dolphin -stylesheet $HOME/.config/qt5ct/qss/dolphin.qss"
alias tmux='tmux -f $HOME/.config/tmux/tmux.conf' t='tmux -f $HOME/.config/tmux/tmux.conf' lf='[ "$TERM" = "alacritty" ] && tmux new-session lf || lf'
alias mi="mediainfo"
alias netstat="netstat --wide"
alias yay="yay --sudoloop"
alias paru="paru --sudoloop"
alias calc="qalc"
alias watch-dir="inotifywait -e modify,create -r \$PWD -m"
alias pacman-fzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias cgrep="grep --color=auto -I -n --exclude-dir=.git"
alias df="df -h"
alias free="free -m"
alias grep-todo='grep --color=auto -r --exclude-dir="\.git" -i -n "TODO" .'
alias gw-ping-tcp="sudo nping --tcp --dest-mac \$(arp | grep "gateway" | sed 's/ * / /g' | cut -d ' ' -f 3) " # [IP] -p [Port]
alias gw-ping-icmp="sudo nping --icmp --dest-mac \$(arp | grep "gateway" | sed 's/ * / /g' | cut -d ' ' -f 3) " # [IP]
alias video-concat-all="ffmpeg -safe 0 -f concat -i <(find . -maxdepth 1 -type f -name '*' -printf \"file '\$PWD/%p'\n\" | sort) -c copy \$(find . -maxdepth 1 -type f -name '*' | sort | head -n 1)-concat.mp4"
alias :q="exit" :Q="exit"
alias h="history -30" clh="[ -f \$HISTFILE ] && echo '' > \$HISTFILE && exec \$SHELL -l"
alias ..="cd .." ...="cd ../.." ....="cd ../../.." .....="cd ../../../.." ......="cd ../../../../.."
alias .1="cd .." .2="cd ../.." .3="cd ../../.." .4="cd ../../../.." .5="cd ../../../../.."
alias ~="cd ~"
alias cp="cp -rv"
alias mv='mv -v'
alias py="python3"
alias cal="cal -m -3 --color=always"
alias cl="clear"  #NOTE: use [Ctrl+l]
alias journalctl-warn="journalctl -p 4"
alias usage="ncdu --exclude /mnt --exclude /.snapshots --exclude /nix"
alias ff="firefox & disown"
alias diskinfo="sudo smartctl -A"
alias package-size-list="pacman -Qi | egrep '^(Name|Installationsgröße)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
alias sudo='sudo '
alias cls='clear'
alias cla='clear'
alias totpof='oathtool --totp -b'
alias lasttotpof='oathtool --totp -b -N "$(date --date="@$(( $(date "+%s") - 60 ))" "+%Y-%m-%d %H:%M:%S")"'
alias ssh-insecure="echo -e '\033[0;33mWarning: Host Key Checking is disabled!\033[0m' && ssh -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no'"
alias scp-insecure="echo -e '\033[0;33mWarning: Host Key Checking is disabled!\033[0m' && scp -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no'"
alias git-insecure="echo -e '\033[0;33mWarning: SSL Verify is disabled!\033[0m' && git -c http.sslVerify=false"
alias ssh-remove='ssh-keygen -R'
alias pip-upgrade="pip freeze --user | cut -d'=' -f1 | xargs -n1 pip install -U"
alias open-ports="sudo ss -tulpn"
alias gparted="sudo -E gparted"
alias k="kubectl"
alias t="terraform"
alias check-yaml="ruby -ryaml -e 'p YAML.load(STDIN.read)' >/dev/null <"
alias yay="paru"

# ls with icons
if command -v lsd >/dev/null ; then
    alias ls="lsd" l="lsd -l" la="lsd -la" lt="lsd -Rl --depth 2" l.='ls -a | egrep "^\." | grep -vE "^(\.|\.\.)$"'
else
    alias l="ls -lh" la="ls -lha"
fi

# web alias
alias public-ip="curl http://ipecho.net/plain; echo"
alias weather="curl v2d.wttr.in/waiblingen"
alias weather-details="curl v2.wttr.in/waiblingen"

# docker, docker-compose
alias dls 'docker container ls'
alias dlog='docker logs -tf --tail="50"' # tail last 50 lines of docker log
alias dprune='docker image prune' # remove unused images (useful after an update)
alias dips=$'docker inspect -f \'{{.Name}}-{{range  $k, $v := .NetworkSettings.Networks}}{{$k}}-{{.IPAddress}} {{end}}-{{range $k, $v := .NetworkSettings.Ports}}{{ if not $v }}{{$k}} {{end}}{{end}} -{{range $k, $v := .NetworkSettings.Ports}}{{ if $v }}{{$k}} => {{range . }}{{ .HostIp}}:{{.HostPort}}{{end}}{{end}} {{end}}\' $(docker ps -aq) | column -t -s-' # prints the IP, network and listening ports for each container.


# git alias
# forgit zsh plugin (see: https://github.com/wfxr/forgit):
# ga (git add selector), glo (git log viewer), gi (gitignore generator), gd (git diff viewer), grh (gir reset HEAD <file> selector), \
# gcf (git checkout <file> selector), gss (git stash viewer), gclean (git clean selector)
alias g="git" gs="git status" gb="git branch" gcmsg="git commit -m" gcm="git commit -m" gco="git checkout" gf="git fetch" \
    gls="git ls-tree -r --name-only HEAD | sort" gm="git merge" greset="git reset --hard HEAD && git clean -f -d" \
    git-edit-last-commit-msg="git commit --amend" gcmsgfix="git commit --amend" git-get-submodules="git submodule update --init --recursive --remote"

alias add="git add -v" branch="git branch" checkout='git checkout' clone="git clone --recursive --recurse-submodules" commit="git commit -m" config='git config -l | sort' init="git init" pull="git pull && git submodule update" push="git push && git lfs push origin \$(git branch | grep '^* ' | cut -c 3-) --all" status="git status -v"

# btrfs
alias btrfs="sudo btrfs"
alias btrfs-recover="dd conv=noerror,sync"  # use btrfs-recover if=corruptFile of=destFileAtOtherDrive
alias btrfs-csum-check="sudo btrfs check --check-data-csum --force"  # use btrfs-csum-check /dev/mapper/xxx
alias btrfs-file-by-bytenr="btrfs inspect-internal logical-resolve"  # use btrfs-file-by-bytenr <bytenr> <path>

# dotfiles bare git repository
if [ -f $HOME/.dotfiles/config ]; then
    alias dotfiles='git -c http.sslVerify=false --git-dir=$HOME/.dotfiles --work-tree=$HOME'
    alias dotfiles-status='dotfiles status -v'
    alias dotfiles-add='dotfiles add -v'
    alias dotfiles-commit='dotfiles add -u && dotfiles commit -m'
    alias dotfiles-ls='dotfiles ls-files --full-name | xargs -I{} echo "$HOME/{}" | sort'
    alias dotfiles-edit='dotfiles-ls | fzf --reverse | xargs -I{} $EDITOR "{}"'
    alias dotfiles-update='dotfiles pull && echo "update completed"'
    alias dotfiles-reset='dotfiles reset --hard HEAD && dotfiles pull; dotfiles submodule update --remote'
    alias dotfiles-search='dotfiles-ls | xargs -I{} echo "\"{}\"" | xargs grep --color=auto -I -n -s -H -i'
    alias dotfiles-todo='dotfiles-search TODO'
    alias .aa="dotfiles add -u -v"
    alias .cmsg='dotfiles commit -m'
    alias .p='dotfiles push --all && dotfiles lfs push origin master --all'
    alias .s='dotfiles status -s'
    alias .ls="dotfiles-ls"
    alias .diff="dotfiles diff"

    # dotfiles add-commit-push function
    function .acp() {
        _dotfiles_command='git -c http.sslVerify=false --git-dir=$HOME/.dotfiles --work-tree=$HOME'
        [ "$(eval "$_dotfiles_command status -s | wc -l")" -le "0" ] && echo "[INFO] There is nothing to commit" && return
        eval "$_dotfiles_command status -s"
        if [ -z "$1" ]; then
            echo -en "commit message: " && read msg
        else
            msg="$@"
            echo "commit message: $msg"
        fi
        [ -z "$msg" ] && msg="update dotfiles"
        echo -en "execute process? [Y/n] " && read choice
        if [ "$choice" = "N" ] || [ "$choice" = "n" ] || [ "$choice" = "no" ] || [ "$choice" = "no" ]; then
            echo "> cancel" && return
        fi
        eval "$_dotfiles_command add -u -v"
        eval "$_dotfiles_command commit -m \"$msg\""
        eval "$_dotfiles_command push --all"
        eval "$_dotfiles_command lfs push origin main --all"
    }

    function  dotfiles-jump-edit() {
        _dotfiles_command='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
        selection=$(eval "$_dotfiles_command ls-files --full-name | xargs grep -I -n -s -H -i \"$@\" | fzf --reverse")
        [ -n "$selection" ] || return
        filePath="$PWD/$(echo "$selection" | cut -d ':' -f 1)"
        fileLine="$(echo "$selection" | cut -d ':' -f 2)"
        eval "$EDITOR +$fileLine $filePath"
    }

    function dotfiles-submodule-remove() {
        _dotfiles_command='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
        [ ! -d .dotfiles ] && echo "you are not in your home directory" && return
        [ ! -f .gitmodules ] && echo ".gitmodules do not exist" && return
        submodulPath="$@"
        grep -q "/$" <<< "$submodulPath" && submodulPath=${submodulPath::-1}
        [ -z "$submodulPath" ] && echo "submodul path not exist" && return
        [ ! -d "$submodulPath" ] && echo "submodul path not exist" && return
        grep -q "path = $submodulPath" .gitmodules || return
        eval "$_dotfiles_command submodule deinit -f \"$submodulPath\""
        rm -rf ".dotfiles/modules/${submodulPath}"
        eval "$_dotfiles_command rm -f \"$submodulPath\""
        echo -e ">> The submodule was successfully removed.\nNote: the changes still have to be committed."
    }
fi

