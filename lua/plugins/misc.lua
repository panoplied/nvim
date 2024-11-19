return {

  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- TODO: consider configuring textobjects via treesitter

      -- Better Around/Inside textobjects
      --
      -- Examples:
      -- - va)    - [V]isually select [A]round [)]paren
      -- - yinq   - [Y]ank [I]nside [N]ext [Q]uote
      -- - ci'    - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw)  - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'    - [S]urround [D]elete [']quotes
      -- - sr)'   - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.is_nerd_font_available })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight todo, notes, etc. in the comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Tmux & split window navigation
    "christoomey/vim-tmux-navigator",
  },

  { -- Git integration for vim
    "tpope/vim-fugitive",
  },

  { -- GitHub integration for fugitive
    "tpope/vim-rhubarb",
  },

  { -- Autoclose parentheses, brackes, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },

  {
    -- Color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }
}
