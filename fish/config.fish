## Installation
# ln -s ~/dotfiles/fish/config.fish ~/.config/fish/
# and Install fisherman
# then, Install all by `fisher up; and fisher .` of fisherman

# vi mode
fish_vi_key_bindings

# greeting message
function fish_greeting
  echo "Hello, $USER!!"
end

## Java
set -x JAVA_HOME (/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8")

## Android
set -x ANDROID_HOME /usr/local/share/android-sdk
set -x HOMEBREW_GITHUB_API 69a78586be8f9595bf7643b78f977d923bac1230

## Flutter
set -x FLUTTER_HOME /Users/nns/flutter

## .NET
set -x DOTNET_HOME /usr/local/share/dotnet

## OpenSSL@1.1
set -x OPENSSL_HOME /usr/local/opt/openssl@1.1

## Google Cloud SDK.
if [ -f '/Users/nns/google-cloud-sdk/path.fish.inc' ]
  if type source > /dev/null
    source '/Users/nns/google-cloud-sdk/path.fish.inc'
  else
    . '/Users/nns/google-cloud-sdk/path.fish.inc'
  end
end

## Root path
set -x PATH $HOME/.nodebrew/current/bin $ANDROID_HOME/4333796/tools $ANDROID_HOME/platform-tools JAVA_HOME/bin $FLUTTER_HOME/bin $DOTNET_HOME/ $OPENSSL_HOME/bin $PATH

## alias
alias e='exit'
alias b='brew' # Need `brew`
alias t='tig' # Need `tig`
alias emu='cd /usr/local/share/android-sdk/tools/' # Need `android-sdk`
alias debug='adb shell input keyevent 82'
alias cat='ccat' # Need `ccat`
alias cask='brew cask' # Need `brew cask`
alias ns='source ~/switch_proxy.fish'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gp='git pull'
alias v='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'
alias git='hub'
alias see='hub browse'
alias issue='hub browse -- issues'
alias pl='hub pull-request'

# execute switch_proxy
ns

