return {
  { -- Configures Lua LSP for Neovim config, runtime and plugins used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        {
          path = "luvit-meta/library",
          words = { "vim%.uv" },
        },
      },
    },
  },

  { "Bilal2453/luvit-meta", lazy = true },

  {
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} }, -- Useful status update for LSP
      "hrsh7th/cmp-nvim-lsp", -- Allow extra capabilities provided by nvim-cmp
    },

    config = function()
      -- Runs when an LSP is attached to a buffer, i.e.
      -- every time a new file is opened that is associated with an LSP,
      -- this autocommand will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- Convenient mapping helper function
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Go to definition
          -- <C-t> - jump back
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition") -- <C-t> to jump back

          -- Find references
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Go to the implementation
          -- Useful when the language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Go to the type of the word under the cursor.
          -- Useful when not sure what type a variable is and want to see
          -- the definition of its *type*,  not where it was *defined*.
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols (variable, functions, types, etc. ) in the document.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in the workspace (entire project).
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename symbol under the cursor. Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action
          -- usually the cursor needs to be on top of an error or a suggestion from the LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- Goto Declaration. WARN: not to definition
          -- For example, in C this would take us to the header.
          map("<gD>", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following autocommands are used to highlight references of the
          -- word under the cursor when the cursor rests there for a little while.
          -- `h: CursorHold` for information about when this is executed.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- When cursor is moved, the highlights are cleared
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- Create a keymap to toggle inlay hints in the code, if the language server supports them
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.is_nerd_font_available then
      --   local signs = { Error = '', Warn = '', Hint = '', Info = '' }
      --   for type, icon in pairs(signs) do
      --     local hl = 'DiagnosticSign' .. type
      --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      --   end
      -- end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {}
        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- Ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      -- Ensure the servers and tools are installed
      -- To check the current status of installed tools and/or manually install other tools,
      -- use `:Mason`, and there `g?` for help
      require("mason").setup()

      -- Add other tools here that we want Mason to install for us
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Lua formatter
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  -- [[ mason-lspconfig ]]
  -- Bridge mason and lspconfig
  -- {
  --   "williamboman/mason-lspconfig",
  --   -- dependencies = { 'mason.nvim', 'neovim/nvim-lspconfig' },
  --   dependencies = { "mason.nvim" }, -- NOTE: can also be 'williamboman/mason.nvim'
  --   config = function()
  --     require("mason-lspconfig").setup()
  --     -- NOTE: `help mason-lspconfig-automatic-server-setup`autom
  --     require("mason-lspconfig").setup_handlers({
  --
  --       -- First entry (without a key) is the default handler
  --       -- called for each server without dedicated handler
  --       function(server_name)
  --         require("lspconfig")[server_name].setup({})
  --       end,
  --
  --       -- Next, you can provide a dedicated handler for specific server.
  --       -- For example, a handler override for the `rust_analyzer`:
  --       -- ['rust_analyzer'] = function()
  --       --     require('rust_tools').setup()
  --       -- end,
  --
  --       ["lua_ls"] = function()
  --         require("lspconfig").lua_ls.setup({
  --           settings = {
  --             Lua = {
  --               diagnostics = {
  --                 -- Get the lua_ls LSP to recognize `vim` global
  --                 -- and supress warnings
  --                 -- globals = { 'vim' },
  --               },
  --             },
  --           },
  --         })
  --       end,
  --     })
  --   end,
  -- },
}
