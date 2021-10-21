# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/vscode/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
  git
  git-extras
  git-flow
  per-directory-history
  ubuntu
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
