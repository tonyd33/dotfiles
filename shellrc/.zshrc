export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fwalch"

zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git colored-man-pages tmux)

source $ZSH/oh-my-zsh.sh
# https://github.com/jeffreytse/zsh-vi-mode
# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.bitwardenenv
source ~/.shellrc/ranger
bindkey -s '^o' 'ranger^M'
source ~/.shellrc/envdef

alias nvmsrc="source ~/.shellrc/nvm"
alias condasrc="source ~/.shellrc/conda"

alias nv="nvim"

export FZF_DEFAULT_OPTS="--preview='bat --style=numbers --color=always {}' --color=bg+:black"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fze() { fzf | xargs -r $EDITOR }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias clipin="xclip -selection clipboard"
alias clipout="xclip -selection clipboard -o"
