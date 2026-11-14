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
    [[ -f "$HOME/apps/nvim-linux-x86_64/bin/nvim" ]] && EDITOR="$HOME/apps/nvim-linux-x86_64/bin/nvim"
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

bindkey '^ ' autosuggest-accept

bindkey '^J' history-substring-search-up
bindkey '^K' history-substring-search-down

bindkey -r '^E'             # unbind default end-of-line
bindkey '^E' edit-command-line

unsetopt MENU_COMPLETE
unsetopt AUTO_MENU
setopt AUTO_LIST
setopt LIST_AMBIGUOUS

source $ZSH/oh-my-zsh.sh

_make() {
    local expl
    compadd -- $(awk -F: '/^[a-zA-Z0-9_.-][^$#\/\t=]*:/ { print $1 }' Makefile 2>/dev/null)
}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

