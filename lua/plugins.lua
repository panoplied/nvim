-- Set up plugins with lazy.nvim

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

-- Setup lazy with plugins
-- requrie("lazy").setup(plugins, opts)
require("lazy").setup({

    -- [[ vim-sleuth ]]
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

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

                        init_selection = "<Leader>ss",
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
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
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
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
