-- [[ OPTIONS ]]

-- NOTE: Must happen before plugins are loaded (otherwises wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.mouse = 'a'

-- vim.opt.showmode = false        -- TODO: consider disabling showing mode when status line plugin installed

vim.opt.wrap = false

-- Use OS clipboard
-- Schedule after `UiEnter` because it can increase startup time
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching unless \C or capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- TODO: enable when which-key popup set
-- vim.opt.timeoutlen = 300

-- Open new vertical splits on the bottom, and horizontal on the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set up some whitespace chars display
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = "split"	-- Preview substitutions realtime in a split 

vim.opt.cursorline = true

-- Allow positioning cursor where there is no actual character in Visual block mode
-- (really convenient for block selections)
vim.opt.virtualedit = "block"

-- Support 24-bit RGB
vim.opt.termguicolors = true


-- [[ KEYMAPS ]]

-- Clear highlights on search when pressing <Esc> in normal mode
-- `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode with simpler shortcut (<Esc><Esc>)
-- NOTE: can be term emulator dependent, us <C-\><C-n> if broken
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation with CTRL+[hjkl>]
-- `:help wincmd`
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Set focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Set focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Set focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Set focus to the upper window" })


-- [[ AUTOCOMMANDS ]]
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
