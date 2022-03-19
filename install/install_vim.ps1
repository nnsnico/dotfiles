try
{
  # 1. add vim synbolic link
  Write-Host "Add symbolic link of .vimrc..."
  if (Test-Path $Env:LOCALAPPDATA\nvim)
  {
    Write-Host "nvim dir is not found. Create dir automatically..."
    New-Item -ItemType Directory $Env:LOCALAPPDATA\nvim\lua

    Write-Host "Add symbolic link of init.vim..."
    New-Item -ItemType SymbolicLink -Path $Env:LOCALAPPDATA\nvim\init.vim -Target $Env:HOME\dotfiles\vim\.vimrc

    Write-Host "Add symbolic link of coc-settings.json in nvim dir..."
    New-Item -ItemType SymbolicLink -Path $Env:LOCALAPPDATA\nvim\coc-settings.json -Target $Env:HOME\dotfiles\vim\packageconfig\coc-settings.json
  }

  Write-Host "Add symbolic link of .gvimrc..."
  New-Item -ItemType SymbolicLink -Path $Env:HOME -Name $Env:HOME\dotfiles\vim\.gvimrc

  Write-Host "Add symbolic link of .ideavimrc..."
  New-Item -ItemType SymbolicLink -Path $Env:HOME\_ideavimrc -Target $Env:HOME\dotfiles\vim\.ideavimrc

  # 2. get 'packer.nvim' installer, and install in '~/AppData/Local/nvim-data/site/pack/packer/start/packer.nvim'
  git clone --depth 1 https://github.com/wbthomason/packer.nvim `
    $Env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim

  New-Item -ItemType SymbolicLink -Path $Env:LOCALAPPDATA\nvim\lua -Name $Env:HOME\dotfiles\vim\vimrcs\packer

  # 3. install vim plugins
  nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

  # TODO: 4. install coc.nvim extensions
  nvim -c "source $Env:HOME\dotfiles\install\install_coc_extensions.vim | q"
}
catch [Exception] {
  $err = 1
  $log = $_
}

Write-Output $log
exit $err
