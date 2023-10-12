local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever plugis.lua file (current one) updated
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- User a protected call so we don't error out on first use
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


-- INSTALL PLUGINS
return packer.startup(function(use)

    -- PLUGIN LIST

    use "wbthomason/packer.nvim"        -- have packer manage itself

    -- Colorschemes
    use "lunarvim/colorschemes"         -- a bunch of colorschemes to try out
    use "folke/tokyonight.nvim"

    -- TODO check if following dependencies are still needed
    use "nvim-lua/popup.nvim"           -- implementation of the popup API from vim in neovim
    use "nvim-lua/plenary.nvim"         -- useful lua function used by lots of plugins

    -- Automatically set up user configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
