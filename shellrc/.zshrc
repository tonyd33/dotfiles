export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fwalch"

zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git colored-man-pages tmux)

source $ZSH/oh-my-zsh.sh
# https://github.com/jeffreytse/zsh-vi-mode
# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.shellrc/ranger
bindkey -s '^o' 'ranger^M'
source ~/.shellrc/envdef

alias nvmsrc="source ~/.shellrc/nvm"

alias nv="nvim"

alias sshgs="ssh -tt tony@10.0.0.119"

export FZF_DEFAULT_OPTS="--preview='bat --style=numbers --pager=never {}' --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fze() { fzf | xargs -r $EDITOR }
