-- Autoinstall packer
local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  print "Cloning packer from github"
  PACKER_BOOTSTRAP = vim.fn.system {
    "git", "clone", "--dept", "1", "https://github.com/wbthomason/packer.nvim", packer_path,
  }
  print "Installing packer"
  vim.cmd "packadd packer.nvim"
end

-- Autoreload nvim on plugins.lua change
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Use plugins
return packer.startup(function(use)

  -- Plugin list
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Color themes
  use "folke/tokyonight.nvim"

-- Automatically set up config after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
