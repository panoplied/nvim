-- [[ lazy.nvim ]]
-- Bootstrap lazy (clone repo and add path to runtimepath)

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Nerd Font Capability ]]
-- Some plugins utilize Nerd Font icons. This is a glob setting to determine their behavior
-- in such case.
-- NOTE: recent versions of Kitty have Nerd Font icons support built in (no need to install font separately).
vim.g.is_nerd_font_available = true

-- [[ Setup lazy with plugins ]]
-- requrie("lazy").setup(plugins, opts)

require("lazy").setup({

    --[[ colorschemes ]]
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme "tokyonight-night"
        end,
    },
    {
        "p00f/alabaster.nvim",
        -- init = function()
        --     vim.cmd.colorscheme "alabaster"
        -- end,
        -- config = function()
        --     vim.g.alabaster_dim_comments = true
        -- end,
    },
    -- "rose-pine/neovim",

    -- [[ vim-sleuth ]]
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- [[ gitsigns ]]
    -- TODO: configure signs
    {
        "lewis6991/gitsigns.nvim",
        -- opts = {},
    },

    -- [[ Telescope ]]
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",     -- before all the UI elements are loaded
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                "nvim-tree/nvim-web-devicons",
                enabled = vim.g.is_nerd_font_available
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make", -- buid runs only on install/update
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")


            -- (`h: telescope.builtin`)
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<Leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<Leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<Leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<Leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<Leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<Leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<Leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files ('.' for repeat)" })
            vim.keymap.set("n", "<Leader><Leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

            vim.keymap.set("n", "<Leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = "[/] Fuzzily search in current buffer" })

            vim.keymap.set("n", "<Leader>s/", function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                }
            end, { desc = "[S]earch [/] in Open Files" })

            vim.keymap.set("n", "<Leader>sn", function()
                builtin.find_files {
                    cwd = vim.fn.stdpath "config"
                }
            end, { desc = "[S]earch [N]eovim Files" })
        end,
    },

    -- [[ which-key ]]
    -- To show pending keybings
    {
        "folke/which-key.nvim",
        event = "VimEnter",     -- before all the UI elements are loaded
        opts = {
            icons = {
                mappings = vim.g.is_nerd_font_available,
                -- When have Nerd Font, use default icons.
                -- Otherwise use string defined in table.
                keys = vim.g.is_nerd_font_available and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-...> ",
                    M = "<M-...> ",
                    D = "<D-...> ",
                    S = "<S-...> ",
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
                { "<Leader>c", group = "[C]ode", mode = { "n", "x" } },
                { "<Leader>d", group = "[D]ocument" },
                { "<Leader>r", group = "[R]ename" },
                { "<Leader>s", group = "[S]earch" },
                { "<Leader>w", group = "[W]orkspace" },
                { "<Leader>t", group = "[T]oggle" },
                { "<Leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            }
        },
    },

    -- [[ nvim-treesitter ]]
    -- Add support for treesitter parsers, incremental selection + setup textobjects
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                auto_install = true,
                highlight = {
                    enable = true,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        -- TODO: reconsider keymaps for incremental selection
                        -- Defaults are:

                        -- init_selection = "gnn",  -- set to `false` to disable one of the mappings
                        -- node_incremental = "grn",
                        -- scope_incremental = "grc",
                        -- node_decremental = "grm",

                        -- TODO: resolve conflict with "<Leader>s" for telescope search
                        -- init_selection = "<Leader>ss",
                        -- node_incremental = "<Leader>si",
                        -- scope_incremental = "<Leader>sc",
                        -- node_decremental = "<Leader>sd",
                    },
                },

                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (defaults is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_string to modes.
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V",  -- linewise
                            ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@funcion.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },

    -- [[ "nvim-treesitter/nvim-treesitter-textobjects" ]]
    -- Add support for text-objects, select, move, swap and peek
    -- NOTE: this table just adds plugin, the module itself is setup in the (prev) nvim-treesitter section
    "nvim-treesitter/nvim-treesitter-textobjects",

    -- [[ nvim-lspconfig ]]
    -- LSP configurer
    -- NOTE: All config is done in mason-lspconfig section
    "neovim/nvim-lspconfig",

    -- [[ mason ]]
    -- Package manager for LSPs etc.
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- [[ mason-lspconfig ]]
    -- Bridge mason and lspconfig
    {
        "williamboman/mason-lspconfig",
        -- dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
        dependencies = { "mason.nvim" },    -- NOTE: can also be "williamboman/mason.nvim"
        config = function()
            require("mason-lspconfig").setup()
            -- NOTE: `help mason-lspconfig-automatic-server-setup`
            require("mason-lspconfig").setup_handlers({

                -- First entry (without a key) is the default handler
                -- called for each server without dedicated handler
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,

                -- Next, you can provide a dedicated handler for specific server.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function()
                --     require("rust_tools").setup()
                -- end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    -- Get the lua_ls LSP to recognize `vim` global
                                    -- and supress warnings
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,

            })
        end,
    },
})
