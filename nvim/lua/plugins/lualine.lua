-- Provides a status line at the bottom of the screen

local spec = {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  -- Once this plugin is loaded, lazy will automatically
  --  call the setup function with these options.
  opts = {}
}

return spec
