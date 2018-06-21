#
# Defines environment variables.
#
# `ln -s /usr/local/opt/zplug/repos/sorin-ionescu/prezto $HOME/.zprezto`
# `ln -s ~/dotfiles/zsh/.zshenv`
#

export ZDOTDIR=~/dotfiles/zsh

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR}/.zprofile"
fi
