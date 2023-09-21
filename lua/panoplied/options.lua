-- :help options
vim.opt.backup = false                          -- don't create backup file
vim.opt.clipboard = "unnamedplus"               -- allow access to the system clipboard
vim.opt.cmdheight = 2                           -- more space in the command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
--vim.opt.ignorecase = true                     -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow using mouse
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true                       -- for all horizontal splits to go below current window
vim.opt.splitright = true                       -- for all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- don't create swap file
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
--vim.opt.writebackup = false
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation level
--vim.opt.softtabstop = 4                       -- insert 4 spaces for a tab
vim.opt.cursorline = true                       -- highlight current line
vim.opt.number = true                           -- show line numbers
vim.opt.relativenumber = true                   -- show relative line numbers
vim.opt.numberwidth = 2                         -- set min number column width to 2 (default is 4)
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- don't wrap lines
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
--
--vim.opt.shortmess:append "c"
--vim.cmd "set whichwrap+=<,>,[,],h,l"
--vim.cmd [[set iskeyword+=-]]
--vim.cmd [[set formatoptions-=cro]]            -- TODO: this doesn't seem to work
