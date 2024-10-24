-- Built-in nvim configuration options
require('core/options')
require('core/keymaps')

-- Load the Lazy plugin manager. This needs to be done
--  after loading the keymaps because lazy expects the
--  leader keys to be mapped to certain values.
require("core/lazy")

-- Mason/LSP setup:
-- The setup functions must be called in the following
--  order.
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls" }
})

local on_attach = function(_, _)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<leader>co", vim.lsp.buf.code_action, {})

  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
  --vim.keymap.set("n", "gr", require("telescope").lsp_references, {})
end
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Now setup the individual language servers
require("lspconfig").clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities
})
require("lspconfig").lua_ls.setup({})

-- Setup nvim-cmp for autocompletion
local cmp = require("cmp")
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  view = {
    docs = { auto_open = false }
  },
  mapping = cmp.mapping.preset.insert({
    -- True: accept currently selected item.
    -- False: only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),

    -- Toggle the documentation window
    ["K"] = cmp.mapping(function(fallback)
      if cmp.visible_docs() then
        cmp.close_docs()
      elseif cmp.visible() then
        cmp.open_docs()
      end
    end),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }
  })
})
