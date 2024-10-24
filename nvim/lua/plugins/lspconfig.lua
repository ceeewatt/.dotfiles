-- A tool used for configuring language servers

local spec = {
  "neovim/nvim-lspconfig",

  -- We don't want to call the setup function here
  --  because (according to the mason-lspconfig docs)
  --  the setup function for the mason lsp plugins
  --  must be called in a particular order.
}

return spec
