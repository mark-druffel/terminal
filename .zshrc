# History settings
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt hist_ignore_all_dups
setopt inc_append_history

# Env Variables
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -f "$REPO_DIR/.env" ] && source "$REPO_DIR/.env"


# Starship
ZSH_THEME="starship"
export STARSHIP_CONFIG=~/Documents/Github/terminal/starship.toml
eval "$(starship init zsh)"

# Path shortcuts
hash -d Github=/home/mark/Documents/Github