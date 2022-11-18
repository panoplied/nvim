local options = {
  noremap = true,
  silent = true,
}

local term_options = {
  silent = true,
}

local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)
keymap("n", "<C-l>", "<C-w>l", options)

keymap("n", "<leader>e", ":Lex 30<cr>", options)
