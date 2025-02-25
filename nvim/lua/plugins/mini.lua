-- mini.nvim is a collection of independent plugins. Each plugin
--  can be enabled separately through calling its respective
--  setup function.

local spec = {
  'echasnovski/mini.nvim',

  -- Stable branch
  version = '*',

  -- To enable a given module, call its setup function here
  config = function()
    -- Surround actions (add `sa`, delete `sd`, replace `sr`, etc)
    require('mini.surround').setup()

    -- Autopairs for quotes, paranthesis, brackets, etc
    require('mini.pairs').setup()
  end
}

return spec
