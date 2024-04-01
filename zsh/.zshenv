# Defines environment variables.
#
#

export ZDOTDIR=~/dotfiles/zsh

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR}/.zprofile"
fi

[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# ----------------------------------- Zinit ------------------------------------

### Added by Zinit's installer
if [[ ! -f $HOME/dotfiles/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/dotfiles/zsh/.zinit" && command chmod g-rwX "$HOME/dotfiles/zsh/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/dotfiles/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi

source "$HOME/dotfiles/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
  "zdharma-continuum/zinit-annex-bin-gem-node"

zinit wait lucid for \
    from'gh-r' \
    as'program' \
    atclone'**/gh completion -s zsh > _gh; zicompinit; zicdreplay' \
    atpull'%atclone' \
    sbin'**/gh' \
  "cli/cli"

# if debian os (Ubuntu)
zinit wait lucid for \
    if'[[ $OSTYPE =~ "linux*" ]]' \
    from"gh-r" \
    bpick"*linux64.tar.gz" \
    ver"nightly" \
    sbin'**/nvim -> nvim' \
  "neovim/neovim"

# if macos
zinit wait lucid for \
    if'[[ $OSTYPE =~ "darwin*" ]]' \
    from"gh-r" \
    bpick"*macos-arm64.tar.gz" \
    ver"nightly" \
    sbin'**/nvim -> nvim' \
  "neovim/neovim"
    # make'CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$ZPFX install' \
    # ver"808752f" \

zinit wait lucid for \
    from"gh-r" \
    sbin"**/v -> v" \
  "vlang/v"

zinit wait lucid for \
    from"gh-r" \
    ver"nightly" \
    sbin"v-analyzer -> v-analyzer" \
  "vlang/v-analyzer"

zinit wait lucid for \
    atclone"git clone --recurse-submodules https://github.com/belak/prezto-contrib contrib && ln -s ~/dotfiles/zsh/.zinit/plugins/sorin-ionescu---prezto ~/.zprezto" \
  "sorin-ionescu/prezto"

zinit wait lucid for \
  "zdharma-continuum/fast-syntax-highlighting"

zinit wait lucid for \
    from"gh-r" \
    sbin"fzf" \
  "junegunn/fzf"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    mv"tig* -> tig" \
    atclone"cd tig; ./configure; make; sudo make install" \
    atpull"%atclone" \
    pick"tig/src/tig" \
  "jonas/tig"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    mv"jq* -> jq" \
  "jqlang/jq"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    sbin"**/rg -> rg" \
  "BurntSushi/ripgrep"

zinit wait lucid for \
    from"gh-r" \
    as"completion" \
    pick"**/complete/_rg" \
  "BurntSushi/ripgrep"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    sbin"**/zoxide -> zoxide" \
    atload'eval "$(zoxide init zsh --cmd cd)"; zicompinit; zicdreplay' \
  "ajeetdsouza/zoxide"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    sbin"**/fd -> fd" \
  "@sharkdp/fd"

zinit wait lucid for \
    pick"contrib/completion/_fd" \
    as"completion" \
  "@sharkdp/fd"

zinit wait lucid for \
    from"gh-r" \
    sbin"**/exa -> exa" \
  "ogham/exa"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    sbin"rogcat-* -> rogcat" \
  "flxo/rogcat"
    # completion is not working
    # atclone'rogcat-* completions zsh > _rogcat; zicompinit; zicdreplay' \
    # atpull'%atclone' \

zinit wait lucid for \
    pick"_gradle" \
    as"completion" \
  "gradle/gradle-completion"

zinit wait lucid for \
    from"gh-r" \
    sbin"**/delta -> delta" \
  "dandavison/delta"

zinit wait lucid for \
    from"gh-r" \
    as"program" \
    atclone'**/zellij setup --generate-completion zsh > _zellij; zicompinit; zicdreplay' \
    atpull'%atclone' \
    sbin"**/zellij -> zellij" \
  "zellij-org/zellij"

# --------------------------- ENVIRONMENT VARIABLES ---------------------------

export GPG_TTY=$(tty)

export _ZO_ECHO='1'
