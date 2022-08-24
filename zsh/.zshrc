# Created by nns

# ----------------------------------- OTHERS -----------------------------------

fpath+=~/.zfunc

# ----------------------------- Setup WSL2(Ubuntu) -----------------------------

if [[ $OSTYPE =~ "linux*" ]]; then
  distribution=$(cat /etc/*-release | awk -F '=' '{if($1=="DISTRIB_DESCRIPTION"){print $2}}' | sed -r "s/\"(.+)\"/\1/")
  # for Ubuntu (also with WSL)
  # one liner command that show intalled package list by apt
  if [[ $distribution =~ "Ubuntu*" ]]; then
      alias apt-installed-list="sudo dpkg -l | tail +6 | awk '{printf(\"%s%%%s%%\",\$2,\$3);for(i=5;i<=NF;++i){if(i!=NF){printf(\"%s \",\$i)}else{printf(\"%s\\n\",\$i)}}}' | column -s '%' -t"
  fi
  # for WSL
  if [[ $(uname -r) =~ "microsoft*" ]]; then
    # support `open` command in WSL
    function open() {
      if [ $# -eq 0 ]; then
        local WSLPATH=$(wslpath -w .)
        /mnt/c/Windows/System32/cmd.exe /c start " " "$WSLPATH" > /dev/null 2>&1
      else
        for dir in $@
        do
          local WSLPATH=$(wslpath -w $dir 2> /dev/null)
          if [ -n "$WSLPATH" ]; then
            /mnt/c/Windows/System32/cmd.exe /c start " " "$WSLPATH" > /dev/null 2>&1
          else
            print -P "%F{160}Path not found: $(realpath "$dir")"
          fi
        done
      fi
    }
  fi
fi

# -------------------------------- Setup macOS ---------------------------------

## Brew-Cask(optional)
## If Acceess permission of root dir is denied
## by your pc, export this PATH.
# export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

## support macos only
if [[ $OSTYPE =~ "darwin*" ]]; then
  ## imgcat
  export ITERM="$HOME/dotfiles/macos/iterm2"
  ## VimR
  export VIMR_HOME="$HOME/dotfiles/macos/vimr"
  export PATH=$PATH:$ITERM:$VIMR_HOME
fi

# ------------------------------------ FZF -------------------------------------

export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
export FZF_DEFAULT_OPTS='--border --layout=reverse --preview="bat {}" --height=60%'

# ---------------------------------- Prezto ------------------------------------

if [[ -s "${HOME}/.zprezto/init.zsh" ]]; then
  source "${HOME}/.zprezto/init.zsh"
fi

# ------------------------------- POWERLEVEL10K --------------------------------

# powerlevel settings
## support awesome font
POWERLEVEL9K_MODE='nerdfont-complete'

## add newline
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
## disable right prompt
POWERLEVEL9K_DISABLE_RPROMPT=true
## customize left prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context newline dir vcs newline custom_proxy_sign vi_mode status)
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B4'
## colorscheme
### context
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='grey19'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='darkolivegreen1'
### dir
POWERLEVEL9K_DIR_HOME_FOREGROUND='grey19'
POWERLEVEL9K_DIR_HOME_BACKGROUND='lightgoldenrod1'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='grey19'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='skyblue1'
### vi_mode
POWERLEVEL9K_VI_INSERT_MODE_STRING="\uE62B INSERT"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="\uE62B NORMAL"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='green1'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='dodgerblue1'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='grey19'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='grey19'
### vcs
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='grey19'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='chartreuse1'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='grey19'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='orchid1'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='grey19'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='darkorange'

# ----------------------------------- ALIAS -----------------------------------

function select_ls() {
  if [ -f $(which exa) ]; then
    command exa $@
  else
    command ls $@
  fi
}

alias nv='nvim'
alias e='exit'
alias ls='select_ls'
alias l='ls'
alias la='(exa -alh --git --time-style=iso || ls -al)'
alias lla='(exa -alh --git --time-style=long-iso || ls -al)'
alias ll='(exa -lh --time-style=iso || ls -l)'
alias nikka='brew update && brew upgrade && brew cleanup && zinit update --all && nvim -c "PackerSync"'

# ------------------------------------ tmux ------------------------------------

# attach tmux when launching terminal
if [ $SHLVL = 1 ]; then
  tmux new-session -d -s mySession -n development && \
  tmux new-window -d -n development.2 && \
  tmux new-window -d -n ssh && \
  tmux new-window -d -n openvpn
  tmux attach -t mySession:development
fi

