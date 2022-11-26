# Custom LunarVim Config

1) Install proper version of neovim https://github.com/neovim/neovim/releases/

2) Install proper version of LunarVim according to https://www.lunarvim.org/docs/installation, for example:
```
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```
3) Add config
```
cd ~/.config/lvim
curl -O https://raw.githubusercontent.com/panoplied/nvim/master/config.lua
```

4) Make sure to have `~/.local/bin` in `$PATH` to be able to launch `lvim`. For example, the contents of `.zshenv` when LunarVim and cargo installed could be like this:
```
typeset -U path PATH
path=(~/.local/bin $path)
path+=(~/.cargo/bin $path)
```

5) Launch `lvim`
