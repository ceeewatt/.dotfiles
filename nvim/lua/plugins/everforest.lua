-- Everforest colorscheme plugin

local spec = {
  "neanias/everforest-nvim",
  version = false,

  -- Always load this plugin on startup. The lazy
  --  documentation suggests to set the priority
  --  of colorschemes to a high value.
  lazy = false,
  priority = 1000,

  -- This function is called after the plugin is loaded
  config = function()
    require("everforest").setup({
      background = "hard"
    })
    vim.cmd("colorscheme everforest")
  end
}

return spec
