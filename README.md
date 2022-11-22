# Custom LunarVim Config

Install LunarVim
```
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

Add config
```
cd ~/.config/lvim
git init
git remote add origin git@github.com:panoplied/nvim.git
git pull origin master --allow-unrelated-histories
```
