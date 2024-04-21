# ZSH config (main)
# NOTE: This file also works from the user home directory if ZDOTDIR environmentvariable is not set. You can copy this file into the user home directory and everything will work properly.

#################################################################################################################
# zsh plugin manager (Update with `zinit update`)
# when you have problemes delete the folder ~/.local/share/zinit
#################################################################################################################

export_systemd_vars() {
    [ -d /usr/lib/systemd/user-environment-generators ] || return
    set -a
    source /dev/fd/0 <<EOF
$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
EOF
    set +a
}

zsh-plugins() {
    # auto install zinit
    if [ ! -f ~/.config/zinit/bin/zinit.zsh ]; then
        mkdir -p ~/.config/zinit
        git clone https://github.com/zdharma-continuum/zinit.git ~/.config/zinit/bin
    fi

    ZSH_DISPLAY='graphical-environment'
    if echo "${$(tty):5}" | grep -q "^tty" ; then
        ZSH_DISPLAY='tty'
    elif [ -v DISPLAY ]; then
        if grep -q "localhost" <<< $DISPLAY ; then
            ZSH_DISPLAY='x11-forwarding'
        else
            ZSH_DISPLAY='graphical-environment'
        fi
    else
        ZSH_DISPLAY='ssh'
    fi

    # init zinit
    source ~/.config/zinit/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    # set default zsh keymap
    [ -n "$ZSH_KEYMAP" ] || export ZSH_KEYMAP="emacs"

    # my zsh functions
    fpath+=( $HOME/.config/zsh/functions )
    for f in $HOME/.config/zsh/functions/* ; do
        autoload -Uz $f
    done

    zinit light spwhitt/nix-zsh-completions

    # require `zoxide binary`
    _ZO_CMD_PREFIX="z"
    zinit ice has'zoxide'
    zinit light z-shell/zsh-zoxide

    # Fuzzy search all text by `Ctrl+P` in a file and open line in `$EDITOR`
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] || [ "$ZSH_DISPLAY" = 'x11-forwarding' ] || [ "$ZSH_DISPLAY" = 'ssh' ]; then
        zinit load mafredri/zsh-async
        zinit load seletskiy/zsh-fuzzy-search-and-edit
    fi

    # Git fzf wrapper
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] || [ "$ZSH_DISPLAY" = 'x11-forwarding' ] || [ "$ZSH_DISPLAY" = 'ssh' ]; then
        zinit light wfxr/forgit
    fi

    # History substring searching
    zinit light zsh-users/zsh-history-substring-search

    # Autosuggestions
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] || [ "$ZSH_DISPLAY" = 'x11-forwarding' ] || [ "$ZSH_DISPLAY" = 'ssh' ]; then
        zinit ice wait lucid atload'_zsh_autosuggest_start'
        zinit light zsh-users/zsh-autosuggestions
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    fi

    # Tab completions
    zinit ice wait lucid blockf atpull'zinit creinstall -q .'
    zinit light zsh-users/zsh-completions

    # Syntax highlighting
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] || [ "$ZSH_DISPLAY" = 'x11-forwarding' ] || [ "$ZSH_DISPLAY" = 'ssh' ]; then
        zinit light zdharma-continuum/fast-syntax-highlighting
    fi

    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] ; then
        # synchronize zsh with system clipboard
        if [ "$ZSH_KEYMAP" = "vim" ]; then
            zinit light kutsan/zsh-system-clipboard
            typeset -g ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT='true'
        fi
    fi

    # my zsh modules
    for f in $HOME/.config/zsh/modules/*.zsh ; do
        source $f
    done

    # fzf tab completions (must be last plugin)
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] || [ "$ZSH_DISPLAY" = 'x11-forwarding' ] || [ "$ZSH_DISPLAY" = 'ssh' ]; then
        zinit light Aloxaf/fzf-tab
    fi

    # zsh theme
    setopt PROMPT_SUBST
    if [ "$ZSH_DISPLAY" = 'graphical-environment' ] ; then
        if command -v starship >/dev/null; then
            eval "$(starship init zsh)"
        else        
            PURE_CMD_MAX_EXEC_TIME=3
            zstyle ':prompt:pure:prompt:success' color green
            zstyle ':prompt:pure:prompt:error' color red
            zstyle ':prompt:pure:git:dirty' color yellow
            zstyle ':prompt:pure:git:stash' show yes
            zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
            zinit light sindresorhus/pure
        fi
    elif [ "$ZSH_DISPLAY" = 'x11-forwarding' ] ; then
        zinit light "$HOME/.config/zsh/theme"
    elif [ "$ZSH_DISPLAY" = 'ssh' ] ; then
        zinit light "$HOME/.config/zsh/theme"
    elif [ "$ZSH_DISPLAY" = 'tty' ] ; then
        PROMPT='%F{blue}%/%f > '
    else
        PROMPT='%F{blue}%/%f > '
    fi

    if command -v direnv >/dev/null ; then
       eval "$(direnv hook zsh)"
    fi
}


#################################################################################################################
# MAIN
#################################################################################################################

function zinit-reinstall() {
    rm -rf $HOME/.config/zsh/.zinit
    rm -rf $HOME/.config/zinit
    zsh
}

zmodload zsh/zprof  # use zprof to profiling zsh
export_systemd_vars
zsh-plugins

trap - INT
# clear
