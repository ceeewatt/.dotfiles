-- Abstraction layer for installing LSP servers,
--  DAP servers, linters, and formatters.

local spec = {
  "williamboman/mason.nvim",

  -- We don't want to call the setup function here
  --  because (according to the mason-lspconfig docs)
  --  the setup function for the mason lsp plugins
  --  must be called in a particular order.
}

return spec
