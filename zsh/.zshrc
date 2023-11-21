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

alias nv='nvim'
alias e='exit'
alias ls='f(){ (command exa "$@" || command ls "$@"); unset -f f; }; f'
alias l='ls'
alias la='f() { (command exa -alh --git --time-style=iso --icons "$@" || command ls -al "$@"); unset -f f; }; f'
alias lla='f() { (command exa -alh --git --time-style=long-iso --icons "$@" || command ls -al "$@"); unset -f f; }; f'
alias ll='f() { (command exa -lh --time-style=iso "$@" || command ls -al "$@"); unset -f f; }; f'

# ----------------------------- Script for Android -----------------------------

function adbdevices() {
  local selected=$(adb devices | rg -v '^$' | tail -n +2 | fzf --select-1 --exit-0 | awk '{print $1}')
  [ -n "$selected" ] && echo "$selected" || (>&2 echo "adbdevices:\tNot selected a device"; exit 1)
}

function adbapps() {
  local device=$1
  if [ -n "$device" ]; then
    command adb -s "$device" shell pm list packages
  elif [ ! -t 0 ]; then # read from pipe input
    read device_from_pipe
    command adb -s "$device_from_pipe" shell pm list packages
  else
    (>&2 echo "adbapps:\tNot selected a device"; exit 1)
  fi
}

function adbstartapp() {
  local device=$(adbdevices)
  local apps=$(adbapps "$device")
  local apppackage=$(echo "$apps" | fzf --select-1 --exit-0 | awk -F':' '{print $2}')
  [ -n "$apppackage" ] && [ -n "$device" ] && \
    command adb -s "$device" shell monkey -p "$apppackage" 1 || \
    (>&2 echo "adbstartapp:\tNot selected an app"; exit 1)
}

function adbps() {
  local device=$1
  if [ -n "$device" ]; then
    command adb -s "$device" shell ps -o PID -o NAME | rg "$1"
  elif [ ! -t 0 ]; then # read from pipe input
    read device_from_pipe
    command adb -s "$device_from_pipe" shell ps -o PID -o NAME | rg "$1"
  else
    (>&2 echo "adbps:\tNo PID"; exit 1)
  fi
}

function adblog() {
  local device=$(adbdevices)
  if ! [[ $# == 0 ]]; then
    [ -n "$device" ] && \
      command adb -s "$device" logcat \
        --pid=$(adb -s "$device" shell ps -o PID -o NAME | rg "$1" | awk '{print $1}') 2>/dev/null | \
        rogcat - && (echo "adblog:\tNo PID"; exit 1)
  else
    [ -n "$device" ] && \
      command adb -s "$device" logcat | \
        rogcat -
  fi
}

function adbunpin() {
  local device=$1
  if [ -n "$device" ]; then
    command adb -s "$device" shell am task lock stop
  elif [ ! -t 0 ]; then # read from pipe input
    read device_from_pipe
    command adb -s "$device_from_pipe" shell am task lock stop
  else
    (>&2 echo "adbunpin: Not selected a device"; exit 1)
  fi
}

function adbtglshowtap() {
  function toggleshowtap() {
    local device=$1
    local value=$(adb -s "$device" shell settings get system show_touches)
    if [ $value = 1 ]; then
      echo "Put \`show_touches\` value to 0"
      command adb -s "$device" shell settings put system show_touches 0
    else
      echo "Put \`show_touches\` value to 1"
      command adb -s "$device" shell settings put system show_touches 1
    fi
  }

  local device=$1
  if [ -n "$device" ]; then
    toggleshowtap $device
  elif [ ! -t 0 ]; then # read from pipe input
    read device_from_pipe
    toggleshowtap "$device_from_pipe"
  else
    (>&2 echo "adbputshowtap: Not selected a device"; exit 1)
  fi
}

# ------------------------------------ tmux ------------------------------------

# attach tmux when launching terminal
if [ $SHLVL = 1 ]; then
  tmux new-session -d -s mySession -n development && \
  tmux new-window -d -n development.2 && \
  tmux new-window -d -n ssh && \
  tmux new-window -d -n openvpn
  tmux attach -t mySession:development
fi

