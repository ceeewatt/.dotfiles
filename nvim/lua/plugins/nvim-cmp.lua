-- Provides autocompletion

local spec = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },

  -- We're going to setup this plugin in the top level
  --  init file because we need to coordinate the setup
  --  with the lspconfig setup.
}

return spec
