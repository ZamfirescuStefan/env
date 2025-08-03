
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

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

plugins=(git zsh-autosuggestions)

export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

ZSH_THEME="robbyrussell"

bindkey '^L' autosuggest-accept

source $ZSH/oh-my-zsh.sh

