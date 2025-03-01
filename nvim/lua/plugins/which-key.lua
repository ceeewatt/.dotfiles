local spec = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- All of the options listed here are copied from the default 
    --  configuration (except for 'delay'). I'm just pasting them
    --  here for reference (see :help which-key.nvim.txt) for all.

    -- Options: "classic", "modern", "helix"
    preset = "classic",
    -- Delay before showing the popup (I think in ms?)
    delay = 500,

    -- WhichKey comes with four built-in plugins
    plugins = {
      -- Show a list of marks (triggered by pressing ' or `)
      marks = true,
      -- Show registers and some useful default keybindings (triggered by
      --  pressing " in normal mode, <C-r> in insert mode).
      registers = true,
      -- Show spelling suggestions when pressing z=
      spelling = {
        enabled = true,
        suggestions = 20
      },
      presets = {
        -- Show help for operators like d, y, etc
        operators = true,
        -- Show help for motions
        motions = true,
        -- Show help for text objects triggered after entering an operator
        text_objects = true,
        -- Show help for <C-w>
        windows = true,
        -- Misc bindings for working with windows
        nav = true,
        -- Help for z and g bindings
        z = true,
        g = true
      }
    },
    -- Optionally disable WhichKey for certain buffer and file types
    disable = {
      ft = {},
      bt = {}
    }
  },

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  }
}

return spec
