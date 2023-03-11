# my dotfiles

![screenshot](snapshots/screenshot.jpeg)

## Description of directory

- dict: merged dictionary file for SKK

- emacs: emacs setting files

- fish: fish setting files(not maintained)

- gh: config file for [GitHub CLI](https://github.com/cli/cli)

- install: installation scripts for vim setup

- macos: application scripts for macOS

- tmux: tmux setting files(tmux.conf, powerline)

- vim: vim setting files(vimrcs)
  - startuptime: `034.329` (2023/2/28)
    - MacBook Air (M1, 2020)
      <details>
      <summary>log</summary>

      ```
      times in msec
      clock   self+sourced   self:  sourced script
      clock   elapsed:              other lines

      000.003  000.003: --- NVIM STARTING ---
      000.045  000.042: event init
      000.116  000.072: early init
      000.302  000.186: locale set
      000.324  000.022: init first window
      000.526  000.202: inits 1
      000.533  000.007: window checked
      000.534  000.001: parsing arguments
      000.791  000.046  000.046: require('vim.shared')
      000.850  000.020  000.020: require('vim._meta')
      000.851  000.059  000.038: require('vim._editor')
      000.852  000.124  000.020: require('vim._init_packages')
      000.853  000.195: init lua interpreter
      000.966  000.113: expanding arguments
      000.982  000.015: inits 2
      001.147  000.166: init highlight
      001.148  000.001: waiting for UI
      003.790  002.642: done waiting for UI
      003.796  000.006: clear screen
      003.881  000.085: init default mappings
      003.889  000.008: init default autocommands
      004.622  000.064  000.064: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/ftplugin.vim
      004.684  000.023  000.023: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/indent.vim
      005.081  000.057  000.057: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/syntax/synload.vim
      005.209  000.092  000.092: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/filetype.lua
      006.564  000.777  000.777: require('vim.filetype')
      007.661  000.719  000.719: require('vim.filetype.detect')
      007.701  002.723  001.078: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/syntax/syntax.vim
      007.746  002.927  000.205: sourcing /Users/nns/dotfiles/vim/vimrcs/visual.vim
      007.796  000.016  000.016: sourcing /Users/nns/dotfiles/vim/vimrcs/search.vim
      007.838  000.015  000.015: sourcing /Users/nns/dotfiles/vim/vimrcs/autocmd.vim
      007.874  000.009  000.009: sourcing /Users/nns/dotfiles/vim/vimrcs/other.vim
      007.960  000.056  000.056: sourcing /Users/nns/dotfiles/vim/vimrcs/functions/trimming_spaces.vim
      008.012  000.026  000.026: sourcing /Users/nns/dotfiles/vim/vimrcs/functions/converter.vim
      008.190  000.035  000.035: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/filetype.lua
      008.236  000.006  000.006: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/ftplugin.vim
      008.264  000.005  000.005: require('vim.keymap')
      009.477  000.326  000.326: require('lazy')
      009.578  000.100  000.100: require('plugins.config.my-telescope')
      009.753  000.167  000.167: require('plugins.config.lsp.my-nvim-lsp-installer')
      009.954  000.064  000.064: require('plugins.config.my-window-picker')
      009.975  000.011  000.011: require('ffi')
      010.206  000.230  000.230: require('lazy.core.cache')
      010.607  000.391  000.391: require('lazy.stats')
      010.688  000.062  000.062: require('lazy.core.util')
      010.744  000.055  000.055: require('lazy.core.config')
      010.835  000.041  000.041: require('lazy.core.handler')
      010.883  000.047  000.047: require('lazy.core.plugin')
      010.888  000.143  000.054: require('lazy.core.loader')
      012.019  000.044  000.044: require('lazy.core.handler.event')
      012.021  000.103  000.059: require('lazy.core.handler.ft')
      012.065  000.041  000.041: require('lazy.core.handler.keys')
      012.106  000.040  000.040: require('lazy.core.handler.cmd')
      012.403  000.012  000.012: sourcing /Users/nns/.local/share/nvim/lazy/v-vim/ftdetect/vlang.vim
      012.673  000.022  000.022: sourcing /Users/nns/.local/share/nvim/lazy/vim-markdown/ftdetect/markdown.vim
      013.160  000.028  000.028: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/filetype.lua
      013.280  000.068  000.068: require('plugins.config.my-nvim-tree')
      013.366  000.037  000.037: require('constants')
      013.368  000.079  000.042: require('plugins.config.my-nvim-bqf')
      013.415  000.039  000.039: require('plugins.config.skkeleton')
      014.640  000.268  000.268: require('aurora')
      015.236  000.011  000.011: require('vim.F')
      015.248  000.911  000.632: sourcing /Users/nns/.local/share/nvim/lazy/aurora/colors/aurora.vim
      015.543  000.017  000.017: sourcing /Users/nns/.local/share/nvim/lazy/nvim-web-devicons/plugin/nvim-web-devicons.vim
      015.997  000.006  000.006: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/_internal/conf.vim
      016.030  000.083  000.077: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops.vim
      016.075  000.248  000.165: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/plugin/denops.vim
      016.118  000.018  000.018: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/plugin/denops/debug.vim
      016.193  000.021  000.021: sourcing /Users/nns/.local/share/nvim/lazy/skkeleton/plugin/skkeleton.vim
      016.325  000.064  000.064: require('plugins.config.heirline.my-heirline')
      016.578  000.252  000.252: require('heirline.conditions')
      016.652  000.073  000.073: require('heirline.utils')
      016.808  000.065  000.065: require('plugins.config.heirline.components.vimode')
      016.851  000.042  000.042: require('plugins.config.heirline.components.skk_status')
      016.893  000.041  000.041: require('plugins.config.heirline.components.filetype')
      016.943  000.048  000.048: require('plugins.config.heirline.components.file_encode_type')
      016.988  000.044  000.044: require('plugins.config.heirline.components.line_status')
      017.043  000.054  000.054: require('plugins.config.heirline.components.diagnostic_status')
      017.180  000.075  000.075: require('plugins.config.heirline.components.file_icon')
      017.333  000.289  000.214: require('plugins.config.heirline.components.file_name')
      017.581  000.144  000.144: require('nvim-navic')
      017.582  000.248  000.104: require('plugins.config.heirline.components.code_context')
      017.710  000.127  000.127: require('plugins.config.heirline.components.winbar')
      017.758  000.047  000.047: require('plugins.config.heirline.components.tabline')
      017.760  001.107  000.100: require('plugins.config.heirline.components')
      017.884  000.124  000.124: require('plugins.config.heirline.theme')
      018.045  000.055  000.055: require('heirline.highlights')
      018.048  000.110  000.056: require('heirline.statusline')
      018.051  000.165  000.055: require('heirline')
      019.740  000.478  000.478: sourcing /Users/nns/.local/share/nvim/lazy/editorconfig-vim/plugin/editorconfig.vim
      019.987  000.192  000.192: sourcing /Users/nns/.local/share/nvim/lazy/editorconfig-vim/ftdetect/editorconfig.vim
      020.753  000.614  000.614: sourcing /Users/nns/.local/share/nvim/lazy/vim-wakatime/plugin/wakatime.vim
      020.954  000.050  000.050: require('plugins.config.my-nvim-notify')
      021.318  000.060  000.060: require('notify.util.queue')
      021.319  000.103  000.043: require('notify.util')
      021.384  000.064  000.064: require('notify.config.highlights')
      021.386  000.216  000.050: require('notify.config')
      021.419  000.033  000.033: require('notify.stages')
      021.495  000.075  000.075: require('notify.service.notification')
      021.643  000.055  000.055: require('notify.animate.spring')
      021.645  000.098  000.043: require('notify.animate')
      021.647  000.151  000.054: require('notify.windows')
      021.808  000.061  000.061: require('notify.service.buffer.highlights')
      021.810  000.109  000.048: require('notify.service.buffer')
      021.811  000.163  000.054: require('notify.service')
      021.871  000.059  000.059: require('notify.stages.util')
      021.874  000.919  000.221: require('notify')
      021.935  000.037  000.037: require('notify.stages.fade_in_slide_out')
      022.162  000.060  000.060: require('vim.lsp.log')
      022.309  000.146  000.146: require('vim.lsp.protocol')
      022.466  000.062  000.062: require('vim.lsp._snippet')
      022.525  000.059  000.059: require('vim.highlight')
      022.537  000.227  000.107: require('vim.lsp.util')
      022.555  000.507  000.073: require('vim.lsp.handlers')
      022.659  000.103  000.103: require('vim.lsp.rpc')
      022.712  000.052  000.052: require('vim.lsp.sync')
      022.791  000.077  000.077: require('vim.lsp.buf')
      022.864  000.073  000.073: require('vim.lsp.diagnostic')
      022.928  000.063  000.063: require('vim.lsp.codelens')
      023.014  001.066  000.191: require('vim.lsp')
      023.173  000.081  000.081: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/gzip.vim
      023.218  000.006  000.006: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/health.vim
      023.280  000.037  000.037: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/man.lua
      023.709  000.083  000.083: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/pack/dist/opt/matchit/plugin/matchit.vim
      023.781  000.477  000.394: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/matchit.vim
      023.887  000.078  000.078: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/matchparen.vim
      024.078  000.166  000.166: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/netrwPlugin.vim
      024.206  000.006  000.006: sourcing /Users/nns/.local/share/nvim/rplugin.vim
      024.209  000.101  000.095: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/rplugin.vim
      024.270  000.032  000.032: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/shada.vim
      024.312  000.011  000.011: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/spellfile.vim
      024.408  000.053  000.053: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/tarPlugin.vim
      024.481  000.043  000.043: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/tohtml.vim
      024.522  000.010  000.010: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/tutor.vim
      024.619  000.069  000.069: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/plugin/zipPlugin.vim
      024.717  015.881  006.379: require('plugins')
      024.718  019.959  000.981: sourcing /Users/nns/.config/nvim/init.lua
      024.721  000.787: sourcing vimrc file(s)
      024.732  000.010: inits 3
      026.989  002.257: reading ShaDa
      027.070  000.081: opening buffers
      027.820  000.750: BufEnter autocommands
      027.821  000.002: editing files in windows
      028.103  000.100  000.100: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/server.vim
      028.222  000.022  000.022: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/_internal/path.vim
      028.282  000.129  000.107: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/_internal/server/proc.vim
      028.357  000.017  000.017: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/_internal/echo.vim
      028.448  000.031  000.031: sourcing /Users/nns/.local/share/nvim/lazy/denops.vim/autoload/denops/_internal/job.vim
      028.929  000.830: VimEnter autocommands
      028.951  000.022: UIEnter autocommands
      029.121  000.098  000.098: sourcing /Users/nns/dotfiles/zsh/.zinit/plugins/neovim---neovim/nvim-macos/share/nvim/runtime/autoload/provider/clipboard.vim
      029.124  000.076: before starting main loop
      030.007  000.648  000.648: require('nvim-web-devicons')
      032.418  000.086  000.086: require('vim.inspect')
      033.018  000.419  000.419: sourcing /Users/nns/.local/share/nvim/lazy/skkeleton/autoload/skkeleton.vim
      033.696  000.417  000.417: require('vim.diagnostic')
      034.328  003.635: first screen update
      034.329  000.001: --- NVIM STARTED ---
      ```

      </details>

- zsh: zsh setting files(zshrc, zprezto)

- root
  - `.skhdrc` , `.yabairc` , `spacebarrc` : [yabai](https://github.com/koekeishiya/yabai) settings
  - `.tigrc` : [tig](https://github.com/jonas/tig) setting

## Requirements

- [NerdFonts](https://github.com/ryanoasis/nerd-fonts) (to use for NeoVim)
- Python
  - Use for [Powerline](https://github.com/powerline/powerline). To install, please see [here](https://powerline.readthedocs.io/en/latest/installation.html#generic-requirements)

## Setup

### Setup Zsh

1. Install zsh
    - recommend to use package manager(e.g., HomeBrew, LinuxBrew ..)

1. Add Symbolic link like below
    ```bash
    # zsh
    $ ln -s ~/dotfiles/zsh/.zshrc ~/
    $ ln -s ~/dotfiles/zsh/.zshenv ~/

    # zprezto via zinit
    $ ln -s ~/dotfiles/zsh/.zinit/plugins/sorin-ionescu---prezto ~/
    ```

### Setup NeoVim

1. Install NeoVim nightly (it will be installed from zinit !)
    - (Optional) To support all plugins, you should also install the following:
        - Node.js >= 12.12
        - Python >= 3
        - Deno (used in [skkeleton](https://github.com/vim-skk/skkeleton))

1. Install to use `install/install_vim.sh`

### Setup tmux

1. Install [tmux](https://github.com/tmux/tmux)

1.
    ```bash
    $ pip install powerline-status
    ```

1.
    ```bash
    $ cp -r $(pip show powerline-status | grep Location | awk '{print $2}')/powerline/config_files ~/.config/powerline
    ```

1. Add symbolic link
    - config file
      ```bash
      $ ln -s ~/dotfiles/tmux/.tmux.conf ~/
      ```
    - powerline top theme file
      1. Windows(WSL2)
          ```bash
          $ ln -sf ~/dotfiles/tmux/powerline.json ~/.config/powerline/themes/
          ```
      1. MacOS
          ```bash
          $ ln -sf ~/dotfiles/tmux/powerline_terminus.json ~/.config/powerline/themes/
          ```
    - powerline theme file
      ```bash
      $ ln -sf ~/dotfiles/tmux/default.json ~/.config/powerline/themes/tmux/default.json
      ```

<!--
vim: ts=2 sts=2 sw=2 et :
-->
