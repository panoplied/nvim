local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Register a handler that will be called for all installed servers
-- Alternatively, you may also register handlers on specific server instances instead
lsp_installer.on_server_ready(function(server)
  local options = {
    on_attach = require("core.lsp.handlers").on_attach,
    capabilities = require("core.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_options = require("core.lsp.settings.jsonls")
    options = vim.tbl_deep_extend("force", jsonls_options, options)
  end

  if server.name == "sumneko_lua" then
    local sumneko_options = require("core.lsp.settings.sumneko_lua")
    options = vim.tbl_deep_extend("force", sumneko_options, options)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.11/20/2022
  server:setup(options)
end)
