-- [[ OPTIONS ]]

vim.opt.number = true
vim.opt.mouse = "a"
-- vim.opt.showmode = true -- TODO: consider disabling showing mode when status line plugin installed
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true -- Case-insensitive search unless \C or capital letters used
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.opt.splitbelow = true -- Vertical splits open below
vim.opt.splitright = true -- Horizontal splits open on the right
vim.opt.inccommand = "split" -- Preview substitutions realtime in a split
vim.opt.cursorline = true
vim.opt.scrolloff = 2 -- TODO: reconsider even having this
vim.opt.sidescrolloff = 2
vim.opt.virtualedit = "block" -- Allow positioning cursor even where is no char (convenient for block selections <C-v>)
vim.opt.termguicolors = true -- Support 24-bit RGB

-- vim.opt.shifwidth = 4
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = true

vim.opt.list = true -- Set up some whitespaces chars display (`h: 'list'`, `h: 'listchars'`)
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Use OS clipboard
vim.schedule(function() -- Schedule after `UiEnter` because it can increase startup time
  vim.opt.clipboard = "unnamedplus"
end)

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

-- [[ AUTOCOMMANDS ]]
-- (`:h lua-guide-autocommands`)

-- Highlight when yanking (`:h vim.highlight.on_yank()`)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

