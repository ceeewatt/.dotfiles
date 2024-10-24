-- Catppuccin colorscheme plugin

local spec = {
  "catppuccin/nvim",
  name = "catppuccin",

  -- Always load this plugin on startup. The lazy
  --  documentation suggests to set the priority
  --  of colorschemes to a high value.
  lazy = false,
  priority = 1000,

  opts = {}
}

return spec
