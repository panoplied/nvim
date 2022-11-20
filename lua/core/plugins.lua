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
      return require("packer.util").float{ border = "rounded" }
    end,
  },
}

-- Use plugins
return packer.startup(function(use)

  -- Essential plugins
  use "wbthomason/packer.nvim"          -- plugin manager
  use "nvim-lua/popup.nvim"             -- popup API
  use "nvim-lua/plenary.nvim"           -- lua functions

  -- Completions
  use "hrsh7th/nvim-cmp"                -- completion plugin for:
  use "hrsh7th/cmp-buffer"              -- buffers
  use "hrsh7th/cmp-path"                -- paths
  use "hrsh7th/cmp-cmdline"             -- commands

  use "hrsh7th/cmp-nvim-lsp"            -- LSP competions
  use "hrsh7th/cmp-nvim-lua"            -- Lua completions (good for configs)

  use "saadparwaiz1/cmp_luasnip"        -- snippet completions

  -- Snippets
  use "L3MON4D3/LuaSnip"                -- snippet engine
  use "rafamadriz/friendly-snippets"    -- a bunch of snippets

  -- LSP
  use "neovim/nvim-lspconfig"           -- enable LSP
  use "williamboman/nvim-lsp-installer" -- language server installer

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- Color themes
  use "folke/tokyonight.nvim"

-- Automatically set up config after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
