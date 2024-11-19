-- TODO: consider merging with misc
return { --- Show pending keybinds
  "folke/which-key.nvim",
  event = "VimEnter", -- before all the UI elements are loaded
  opts = {
    icons = {
      mappings = vim.g.is_nerd_font_available,
      -- When have Nerd Font, use default icons. Otherwise use strings defined in table.
      keys = vim.g.is_nerd_font_available and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-…> ",
        M = "<M-…> ",
        D = "<D-…> ",
        S = "<S-…> ",
        CR = "<CR> ",
        Esc = "<ESC> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },

    -- Document existing key chaings
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    },
  },
}
