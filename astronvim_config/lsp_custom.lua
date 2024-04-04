local M = {}

M.config = function()
  local lspconfig = require("lspconfig")

  -- Custom LSP server configurations
  local servers = {
    pyright = {
      capabilities = {
        textDocument = {
          publishDiagnostics = {
            tagSupport = {
              valueSet = { 2 },
            },
          },
        },
      },
    },
    -- ruff_lsp = {}, -- You can add custom configurations for other LSP servers here
  }

  -- Apply the custom configurations
  for server, config in pairs(servers) do
    local server_opts = lspconfig[server].opts or {}
    lspconfig[server].setup(vim.tbl_deep_extend("force", server_opts, config))
  end
end

return M
