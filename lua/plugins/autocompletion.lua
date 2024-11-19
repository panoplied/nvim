return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp", -- Build step is needed for regex support in snippets.
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
    -- Adds other completion capabilities.
    -- nvim-cmp does not ship with all sources by default. The are split
    -- into multiple repos for maintainance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },

  config = function()
    -- `h: cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    local kind_icons = {
      Text = "󰉿",
      Method = "m",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰆧",
      Class = "󰌗",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰇽",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(), -- Select the [n]ext item
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll the documentation window [f]orward

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),

        -- Manually trigger a completion from nvim-cmp. Generally don't need this,
        -- because nvim-cmp will display completions whenever it has completion options available.
        ["<C-Space>"] = cmp.mapping.complete({}),

        -- Think of <c-l> as moving to the right of your snippet expansion.
        -- So if you have a snippet that's like:
        -- funct
        --   $body
        -- end
        --
        -- <C-l> will move you to the right of each of the expansion locations.
        -- <C-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      }),

      sources = {
        {
          name = "lazydev",
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        -- { name = "buffer" },
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            path = "[Path]",
            -- buffer = "[Buffer]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
}
