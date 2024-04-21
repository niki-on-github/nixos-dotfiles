export BROWSER="firefox"
export EDITOR="hx"
export READER="zathura"
export TERMINAL="alacritty"
export GDK_DPI_SCALE=1.4
export QT_SCALE_FACTOR=1.4
export QT_QPA_PLATFORMTHEME="qt5ct"
export MAKEFLAGS="-j$(expr $(nproc) \+ 1)"
export XKB_DEFAULT_LAYOUT=de
export SUDO_ASKPASS="$HOME/.local/bin/system/menu-askpass"
export SSH_ASKPASS="$HOME/.local/bin/system/menu-askpass"
export FZF_DEFAULT_OPTS='
  --color=bg+:-1,bg:-1,spinner:#1d99f3,hl:#1d99f3,gutter:-1
  --color=fg:-1,header:#1d99f3,info:#707070,pointer:#d7005f
  --color=marker:#1d99f3,fg+:#ffffff,prompt:#d7005f,hl+:4'
