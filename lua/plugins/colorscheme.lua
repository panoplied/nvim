return {
  "rebelot/kanagawa.nvim",
  -- "folke/tokyonight.nvim",
  -- "EdenEast/nightfox.nvim",
  -- "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("kanagawa-dragon")
    -- vim.cmd.colorscheme("tokyonight-night")
    -- vim.cmd.colorscheme("carbonfox")
    -- vim.cmd.colorscheme("catppuccin-mocca")
  end,
}
