-- This is the lazy plugin manager for installing and managing
--  all of my plugins. The following chunk of code bootstraps
--  the lazy plugin manager. This is copied from the
--  documentation page.

-- Use the standard 'data' path. Check whether or not lazy
--  is already installed. If not installed, clone the repo
--  and install it. Add the lazy path to our runtimepath.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  -- Debug information from me
  print("[Lazy] installing lazy plugin manager to: " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- This setup function should install and setup each plugin
--  that we have in the 'lua/plugins' directory.
require("lazy").setup({
  -- Each file in the plugins directory should return a table
  --  containing the specs about each plugin. The properties
  --  of the plugin spec table is are listed in the docs.
  spec = {
    { import = "plugins" },
  },

  -- Configure any other settings here. See the documentation
  --  for more details.

  -- This isn't really documented anywhere. Apparently, this
  --  is the colorscheme to use when installing missing plugins.
  --  It happens before our regular colorscheme is loaded, so
  --  this is just a temporary colorscheme to use. Not sure why
  --  this matters.
  install = { colorscheme = { "habamax" } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})
