# Created by newuser for 5.1.1

# export
## proxy
#export proxy=http://a1502433:o5r2j1m4@wwwproxy.kanazawa-it.ac.jp:8080
#export http_proxy=$proxy
#export https_proxy=$proxy

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
alias grep='grep -G'
alias ls='ls -G'
alias lst='ls -ltrG'
alias l='ls -ltrG'
alias la='ls -laG'
alias ll='ls -lG'
alias home='cd ~'
alias e='exit'
alias emu='cd /usr/local/share/android-sdk/tools/'
alias cask='brew cask'

# 補完機能設定
autoload -U compinit

compinit

# プロンプト
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='
%F{154}[%* %n@%m:%~]%f `vcs_echo`
%(?.%B%F{034}>%f%F{082}>%f%F{086}>%f%b.%B%F{red}>%f%F{magenta}>%f%F{yellow}>%f%B) '

# 補完候補一覧をカラー表示する設定
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完候補のカーソル選択を有効にする設定
zstyle ':completion:*:default' menu select=1

# コマンドエラーの修正
setopt nonomatch

# #補完を大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
