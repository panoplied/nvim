-- [[ KEYMAPS ]]

-- Clear search highlights when pressing <Esc> in normal mode (`:h hlsearch`)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode with simpler shortcut (<Esc><Esc>) (NOTE: term dependent, use <C-\><C-n> if broken)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation with CTRL+[hjkl] (`:h wincmd`)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Set focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Set focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Set focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Set focus to the upper window" })

-- Stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
