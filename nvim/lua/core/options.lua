-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- ???
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Enable mouse
vim.opt.mouse = 'a'

-- Load the corresponding ftplugin file (if there is one for
--  the detected filetype). Note: I added this originally
--  to run the make.vim ftplugin for makefiles because
--  I needed to appropriate tab settings for that filetype.
vim.cmd("filetype plugin on")

-- Disable text wrapping, make searching case insentive, and
--  ignore case when completing file names/directories.
vim.cmd("set nowrap")
vim.cmd("set ignorecase")
vim.cmd("set wildignorecase")

--[[
-- Tab Control
]]
-- Number of visual spaces for <TAB>
vim.opt.tabstop = 2

-- Number of spaces for <TAB> when editing
vim.opt.softtabstop = 2

-- Insert 2 spaces for a <TAB>
vim.opt.shiftwidth = 2

-- Tabs are spaces
vim.opt.expandtab = true

--[[
-- UI Control
]]
-- Show absolute line number
vim.opt.number = true

-- Add line numbers to each line on the left side
vim.opt.relativenumber = true

-- Highlight cursor line underneath
vim.opt.cursorline = true

-- Open new vertical split botton
vim.opt.splitbelow = true

-- Open new horizontal split right
vim.opt.splitright = true

-- Display the current mode
vim.opt.showmode = true

-- Default color group
vim.opt.background = "dark"

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Disable the default syntax highlighting since
--  we instead want the syntax highlighting provided
--  with treesitter.
vim.cmd("syntax off")

-- Display use a dot for displaying all whitespace characters.
-- Use a '->' for displaying tabs.
vim.cmd("set list")
vim.cmd("set listchars+=space:·")
vim.cmd("set listchars+=lead:·")
vim.cmd("set listchars+=trail:·")
vim.cmd("set listchars+=tab:->")

--[[
-- Autocommands
--]]
vim.api.nvim_create_autocmd(
  "FileType",
  {
    desc = "For C/C++ files, change the default commentstring from /**/ to //.",
    pattern = {"c", "cpp"},
    command = "setlocal commentstring=//%s"
  }
)
