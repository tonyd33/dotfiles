export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fwalch"

zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git colored-man-pages tmux)

source $ZSH/oh-my-zsh.sh
# https://github.com/jeffreytse/zsh-vi-mode
# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.bitwardenenv
source ~/.shellrc/ranger
source ~/.shellrc/envdef

alias nvmsrc="source ~/.shellrc/nvm"

SCRIPTS_PATH=/home/tony/.local/bin
PATH=$PATH:$SCRIPTS_PATH
