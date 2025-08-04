
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Darwin" ]]; then
  export EDITOR="/opt/homebrew/bin/nvim"
  export PATH="/opt/homebrew/bin:$PATH"
  alias ls="ls -G"  # macOS uses -G for color
elif [[ "$OS_TYPE" == "Linux" ]]; then
  export EDITOR="/usr/bin/nvim"
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  alias ls="ls --color=auto"  # Linux uses --color=auto
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

plugins=(git zsh-completions zsh-autosuggestions copypath history-substring-search zsh-syntax-highlighting)

bindkey '^L' autosuggest-accept

bindkey '^J' history-substring-search-up
bindkey '^K' history-substring-search-down

unsetopt MENU_COMPLETE
unsetopt AUTO_MENU
setopt AUTO_LIST
setopt LIST_AMBIGUOUS

_make() {
  local expl
  compadd -- $(awk -F: '/^[a-zA-Z0-9_.-][^$#\/\t=]*:/ { print $1 }' Makefile 2>/dev/null)
}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

