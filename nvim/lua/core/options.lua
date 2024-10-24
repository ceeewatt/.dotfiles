-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- ???
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Enable mouse
vim.opt.mouse = 'a'

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

-- Display whitespace characters with (U+2022)
vim.opt.list = true
vim.opt.listchars = "tab:• ,lead:•,trail:•"
