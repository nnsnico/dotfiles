# Created by nns

# initial zplug
## Source Prezto
if [[ -s "${HOME}/.zprezto/init.zsh" ]]; then
  source "${HOME}/.zprezto/init.zsh"
fi

## Network

### Handling proxy (support mac only)
function handleproxy() {
  {
    autoload -Uz catch
    autoload -Uz throw
    local airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    ssid= [ -f $airport ] && `airport -I | awk -F': ' '/ SSID/ {print $2}'` || throw 'AirportNotFound'
    echo "[network] current ssid: $ssid"
      if [ $ssid = 'aoyamafan' ]; then
        echo '[network] proxy is set'
          local decryptpath='/home/nnsnico/dotfiles'
          local name=`cat ${decryptpath}/yabai_yatsu.txt | awk -F ': ' '/id/ {print $2}'`
          local pass=`cat ${decryptpath}/yabai_yatsu.txt | awk -F ': ' '/password/ {print $2}'`
          export http_proxy="http://${name}:${pass}@proxy.gate.fancs.com:8080"
          export https_proxy="http://${name}:${pass}@proxy.gate.fancs.com:8080"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN='echo "󿦌"'
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_FOREGROUND="grey19"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_BACKGROUND="greenyellow"
      elif [ -n $http_proxy ] && [ -n $https_proxy ]; then
          unset http_proxy
          unset https_proxy
          POWERLEVEL9K_CUSTOM_PROXY_SIGN='echo "󿦍"'
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_FOREGROUND="white"
          POWERLEVEL9K_CUSTOM_PROXY_SIGN_BACKGROUND="dodgerblue2"
      fi
  } always {
    echo 'Error occurred while setting proxy'
    if catch '*'; then
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

# export
## Brew-Cask(optional)
## If Acceess permission of root dir is denied
## by your pc, export this PATH.
# export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

## FZF
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
export FZF_DEFAULT_OPTS='--border --layout=reverse --preview="bat {}" --height=60%'

## zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

## Add to plugins
zplug "sorin-ionescu/prezto"
zplug "peco/peco"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"

zplug load

## OpenSSL@1.1
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

## Java
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`

## Android
export ANDROID_HOME="/usr/local/share/android-sdk"
export ANDROID_SDK_ROOT=$ANDROID_HOME
export HOMEBREW_GITHUB_API_TOKEN="69a78586be8f9595bf7643b78f977d923bac1230"

## flutter
export FLUTTER_HOME="/Users/nns/flutter"

## .NET
export DOTNET_HOME="/usr/local/share/dotnet"

## Tex
export TEX_HOME="/Library/TeX/texbin"

export TERM="xterm-256color"

## Root Path
export PATH=~/.nodebrew/current/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$FLUTTER_HOME/bin:$DOTNET_HOME/:$TEX_HOME/:$(go env GOPATH)/bin:$PATH

# alias
alias v='/usr/local/bin/vim'
alias nv='/usr/local/bin/nvim'
alias e='exit'
alias ls='exa'
alias l='ls -ltrG'
alias la='ls -alG'
alias ll='ls -lG'
alias emu='cd /usr/local/share/android-sdk/tools/'
alias b='brew'
alias stk='stack build && stack exec'
alias git='hub'
alias see='hub browse'
alias issue='hub browse -- issues'
alias pl='hub pull-request'
alias peco='peco --initial-matcher Regexp'
alias pcd='cd $(ls -a | peco)'
alias nikka='brew update && brew upgrade && brew cleanup && zplug update && vim +":call dein#update()" +:q'

