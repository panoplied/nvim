vim.g.mapleader = " "

vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true        -- Write spaces insted of <Tab>
vim.opt.tabstop = 4             -- Interpreted tab size when reading and writing files
vim.opt.shiftwidth = 4          -- Indent/Deindent step size (basically when >>, << or <Tab> is used for indenting during edit)

-- vim.opt.scrolloff = 999         -- (?) do I really need always centered line

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"	-- Preview substitute command results in separate split
vim.opt.ignorecase = true       -- Ignore case when entering commands
vim.opt.termguicolors = true
