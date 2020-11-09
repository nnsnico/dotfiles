my dotfiles

![](snapshots/screenshot.png)

## Description of directory

- emacs: emacs settings

- fish: fish settings(not maintained)

- install: vim install scripts

- macos: application scripts for macOS

- tmux: tmux settings(tmux.conf, powerline)

- vim: vim settings(vimrcs, coc.nvim, vint)

- zsh: zsh settings(zshrc, zprezto)

- root

    - `.skhdrc` , `.yabairc` , `spacebarrc` : [yabai](https://github.com/koekeishiya/yabai) settings

    - `.tigrc` : [tig](https://github.com/jonas/tig) setting

    - `Brewfile` : Dumped install list in HomeBrew (not maintained)

## Installation

### General Installation

1. (MUST) Install NerdFonts

    - Use vim-devicon, powerline-extra, and more. so not work only powerline.

1. Clone this repositroy

### Shell(Zsh) Installation

1. Install zsh
    - recommend to use package manager(e.g., HomeBrew, LinuxBrew ..)

1. Add Symbolic link like below

```
# zsh
$ ln -s ~/dotfiles/zsh/.zshrc ~/
$ ln -s ~/dotfiles/zsh/.zshenv ~/

# zprezto via zinit
$ ln -s ~/dotfiles/zsh/.init/plugins/sorin-ionescu---prezto ~/
```

### Vim(also can use NeoVim) Installation

1. Install Vim or NeoVim

1. Install to use `install/install_vim.sh`

### tmux Installation

1. Install [powerline](https://github.com/powerline/powerline)

    1. `pip install powerline-status`

    1. `cp -r $(pip show powerline-status | grep Location | awk '{print $2}')/powerline/config_files ~/.config/powerline`

1. Add symbolic link

    1. `ln -s ~/dotfiles/tmux/.tmux.conf`

    1. (Windows(Windows Terminal or Alacritty)) `ln -s ~/.config/powerline/themes/powerline.json ~/dotfiles/tmux/powerline.json`

    1. (MacOS(iTerm2)) `ln -s ~/.config/powerline/themes/powerline.json ~/dotfiles/tmux/powerline_terminus.json`

<!--
vim: ts=4 sts=4 sw=4 et :
-->
