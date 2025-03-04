-- Treesitter plugin for syntax highlighting. This plugin
--  creates a Concrete Syntax Tree (CST) for a given file
--  which can be used for providing common ide features.

local spec = {
  "nvim-treesitter/nvim-treesitter",

  -- Run this command whenever this plugin is built
  build = ":TSUpdate",

  -- This function is called after the plugin is loaded
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "cpp", "lua", "make", "vimdoc", "markdown", "markdown_inline", "bash", "cmake" },
      sync_install = false,
      auto_install = false,
      ignore_install = { },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}

return spec
