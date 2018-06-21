# Created by nns

# initial zplug
## Source Prezto
if [[ -s "${HOME}/.zprezto/init.zsh" ]]; then
  source "${HOME}/.zprezto/init.zsh"
fi

# export
## zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

## Add to plugins
zplug "sorin-ionescu/prezto"
zplug "zsh-users/zsh-completions"

## Java
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`

## Android
export ANDROID_HOME="/usr/local/share/android-sdk"
export HOMEBREW_GITHUB_API_TOKEN="7f26821f55886f6bd7bcba6d47e85c24937c8ee1"

## flutter
export FLUTTER_HOME="/Users/nns/flutter"

## Root Path
export PATH=~/.nodebrew/current/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$FLUTTER_HOME/bin:$PATH

# alias
alias v='/usr/local/bin/vim'
alias e='exit'
alias l='ls -ltrG'
alias la='ls -alG'
alias ll='ls -lG'
alias emu='cd /usr/local/share/android-sdk/tools/'
alias cat='ccat'
alias ns='source ~/switch_proxy.sh'
alias b='brew'

