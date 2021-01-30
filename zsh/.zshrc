# Created by nns

# ----------------------------------- OTHERS -----------------------------------

fpath+=~/.zfunc

if [[ $OSTYPE =~ "linux*" ]]; then
  distribution=$(cat /etc/*-release | awk -F '=' '{if($1=="DISTRIB_DESCRIPTION"){print $2}}' | sed -r "s/\"(.+)\"/\1/")
  # one liner command that show intalled package list by apt
  if [[ $distribution =~ "Ubuntu*" ]]; then
      alias apt-installed-list="sudo dpkg -l | tail +6 | awk '{printf(\"%s%%%s%%\",\$2,\$3);for(i=5;i<=NF;++i){if(i!=NF){printf(\"%s \",\$i)}else{printf(\"%s\\n\",\$i)}}}' | column -s '%' -t"
  fi
  # for WSL
  if [[ $(uname -r) =~ "microsoft*" ]]; then
    # support `open` command in WSL
    function open() {
      if [ $# -eq 0 ]; then
        cmd.exe /c start " " .
      elif [ $# -eq 1 ]; then
        local WSLPATH=$(wslpath -w $1)
        /mnt/c/Windows/System32/cmd.exe /c start " " "$WSLPATH" > /dev/null 2>&1
      else
        echo "ERROR: Too many arguments"
      fi
    }
  fi
fi

# ----------------------------------- zinit -----------------------------------

### Added by Zinit's installer
if [[ ! -f $HOME/dotfiles/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/dotfiles/zsh/.zinit" && command chmod g-rwX "$HOME/dotfiles/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/dotfiles/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/dotfiles/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid atclone"git clone --recurse-submodules https://github.com/belak/prezto-contrib contrib && ln -s ~/dotfiles/zsh/.zinit/plugins/sorin-ionescu---prezto ~/.zprezto" for \
  "sorin-ionescu/prezto"
zinit wait lucid for \
  "peco/peco" \
  "zdharma/fast-syntax-highlighting"
# install binary from github release
zinit wait lucid from"gh-r" as"program" for \
  "junegunn/fzf" \
  "jonas/tig"
# install ripgrep binary with completion
zinit wait lucid from"gh-r" mv"ripgrep* -> ripgrep" for \
  as"program" pick"ripgrep/rg" "BurntSushi/ripgrep" \
  as"completion" pick"ripgrep/complete/_rg" atload"zicompinit; zicdreplay" "BurntSushi/ripgrep"
# use completion for `git switch`
zinit wait lucid as"completion" atload"zicompinit; zicdreplay" mv"git-completion.zsh -> _git" for \
  "https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh"

# ---------------------------------- Prezto ------------------------------------

if [[ -s "${HOME}/.zprezto/init.zsh" ]]; then
  source "${HOME}/.zprezto/init.zsh"
fi

# ------------------------------- POWERLEVEL10K --------------------------------

### Handling proxy (support mac only)
function handleproxy() {
  {
    autoload -Uz catch
    autoload -Uz throw
    local airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    local ssid=''
    if [ -f $airport ]; then
      ssid=`$airport -I | awk -F': ' '/ SSID/ {print $2}'`
    else
      throw 'AirportNotFound'
    fi
    echo "[network] current ssid: $ssid"
      if [ $ssid = 'aoyamafan' ]; then
        echo '[network] proxy is set'
          local decryptpath="$HOME/dotfiles"
          local name=`cat ${decryptpath}/yabai_yatsu.txt | awk -F ': ' '/id/ {print $2}'`
          local pass=`cat ${decryptpath}/yabai_yatsu.txt | awk -F ': ' '/password/ {print $2}'`
          export http_proxy="http://${name}:${pass}@proxy.gate.fancs.com:8080"
          export https_proxy="http://${name}:${pass}@proxy.gate.fancs.com:8080"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN='echo "\uF98C"'
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_FOREGROUND="grey19"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_BACKGROUND="greenyellow"
      elif [ -n $http_proxy ] && [ -n $https_proxy ]; then
          unset http_proxy
          unset https_proxy
          POWERLEVEL9K_CUSTOM_PROXY_SIGN='echo "\uF98D"'
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_FOREGROUND="white"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_BACKGROUND="dodgerblue2"
      fi
  } always {
    if catch '*'; then
      echo 'Error occurred while setting proxy'
      case $CAUGHT in
        (AirportNotFound)
          echo 'Airport command is not found'
          ;;
        (*)
          echo 'Unexpected Error'
          ;;
      esac
    fi
  }
}

handleproxy

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

# --------------------------- ENVIRONMENT VARIABLES ---------------------------

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

## FZF
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
export FZF_DEFAULT_OPTS='--border --layout=reverse --preview="bat {}" --height=60%'


## OpenSSL@1.1
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

## Java
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`

## Android
export ANDROID_HOME="/usr/local/share/android-sdk"
export ANDROID_SDK_ROOT=$ANDROID_HOME

## flutter
export FLUTTER_HOME="/Users/nns/flutter"

## .NET
export DOTNET_HOME="/usr/local/share/dotnet"

## Tex
export TEX_HOME="/Library/TeX/texbin"

## Root Path
export PATH=~/.nodebrew/current/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$FLUTTER_HOME/bin:$DOTNET_HOME/:$TEX_HOME/:$(go env GOPATH)/bin:$PATH

# ----------------------------------- ALIAS -----------------------------------

function select_ls() {
  if type "exa" > /dev/null 2>&1; then
    exa $@
  else
    ls $@
  fi
}

alias v='$(which vim)'
alias nv='$(which nvim)'
alias e='exit'
alias ls='select_ls'
alias l='ls'
alias la='exa -alh --git --time-style=iso || ls -al'
alias lla='exa -alh --git --time-style=long-iso || ls -al'
alias ll='exa -lh --time-style=iso || ls -l'
alias emu='cd /usr/local/share/android-sdk/tools/'
alias b='brew'
alias stk='stack build && stack exec'
alias git='hub'
alias see='hub browse'
alias issue='hub browse -- issues'
alias pl='hub pull-request'
alias peco='peco --initial-matcher Regexp'
alias pcd='cd $(ls -a | peco)'
alias nikka='brew update && brew upgrade && brew cleanup && zinit update --all && vim +":call dein#update()" +:q'

# ------------------------------------ tmux ------------------------------------

# attach tmux when launching terminal
if [ $SHLVL = 1 ]; then
  tmux new-session -d -s mySession -n development && \
  tmux new-window -d -n development.2 && \
  tmux new-window -d -n ssh && \
  tmux new-window -d -n openvpn
  tmux attach -t mySession:development
fi

