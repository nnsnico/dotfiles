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
    bpick"*macos.tar.gz" \
    ver"nightly" \
    sbin'**/nvim -> nvim' \
  "neovim/neovim"

zinit wait lucid for \
    from"gh-r" \
    sbin"**/v -> v" \
  "vlang/v"

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
  "stedolan/jq"

zinit wait lucid for \
    from"gh-r" \
    sbin"**/rg -> rg" \
  "BurntSushi/ripgrep" \
    as"completion" \
    pick"ripgrep/complete/_rg" \
    atload"zicompinit; zicdreplay" \
  "BurntSushi/ripgrep"

zinit wait lucid for \
    from"gh-r" \
    sbin"**/zoxide -> zoxide" \
    atpull"rm ~/.zcompdump*; compinit" \
    atload'eval "$(zoxide init zsh --cmd cd)"' \
  "ajeetdsouza/zoxide" \

zinit wait lucid for \
    from"gh-r" \
    sbin"**/exa -> exa" \
  "ogham/exa"

# use completion for `git switch`
zinit wait silent lucid for \
    atclone"zstyle ':completion:*:*:git:*' script git-completion.bash" \
    atpull"%atclone" \
  "https://github.com/git/git/blob/master/contrib/completion/git-completion.bash"

zinit wait lucid for \
    as"completion" \
    atload"zicompinit; zicdreplay" \
    mv"git-completion.zsh -> _git" \
  "https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh"

# --------------------------- ENVIRONMENT VARIABLES ---------------------------

export _ZO_ECHO='1'
