local options = {
  noremap = true,
  silent = true,
}

local term_options = {
  silent = true,
}

local keymap = vim.api.nvim_set_keymap

-- NORMAL MODE

-- Window navigation: CTRL + hjkl
keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)
keymap("n", "<C-l>", "<C-w>l", options)

-- Window resizing:
keymap("n", "<C-Left>",  ":vertical resize -2<cr>", options)
keymap("n", "<C-Down>",  ":resize -2<cr>", options)
keymap("n", "<C-Up>",    ":resize +2<cr>", options)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", options)

-- File explorer: \ + e
keymap("n", "<leader>e", ":Lex 30<cr>", options)

-- VISUAL MODE

-- Keep indenting active
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- Move lines up/down
keymap("v", "<A-j>", ":m .+1<cr>==", options)
keymap("v", "<A-k>", ":m .-2<cr>==", options)
