-- Abstraction layer for installing LSP servers,
--  DAP servers, linters, and formatters. This
--  plugin is an extension to the existing mason
--  plugin. It's designed to help bridge the gap
--  between mason and lspconfig.

local spec = {
  "williamboman/mason-lspconfig.nvim",

  -- We don't want to call the setup function here
  --  because (according to the mason-lspconfig docs)
  --  the setup function for the mason lsp plugins
  --  must be called in a particular order.
}

return spec
