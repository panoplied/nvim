-- [[ lazy.nvim ]]
-- Bootstrap lazy (clone repo and add path to runtimepath)
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Nerd Font Capability ]]
-- Some plugins utilize Nerd Font icons. This is a glob setting to determine their behavior in such case.
-- NOTE: If using Kitty, its recent versions have Nerd Font icons support built in (no need to install font separately).
vim.g.is_nerd_font_available = true

require("lazy").setup({
  require("plugins.colorscheme"),
  -- require("plugins.neotree"),
  require("plugins.whichkey"),

  require("plugins.telescope"),
  require("plugins.treesitter"),
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.autoformatting"),
  require("plugins.gitsigns"),

  -- TODO: consider bufferline ?
  -- TODO decide on mini.statusline vs lualine
  -- require("plugins.lualine"),

  -- TODO: consider adding dashboard/splashscreen

  require("plugins.misc")
})
