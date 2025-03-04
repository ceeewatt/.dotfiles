-- Use system clipboard
vim.cmd("set clipboard+=unnamedplus")

vim.cmd("set ignorecase")

-- Enable mouse
vim.opt.mouse = 'a'

-- Print line number
vim.cmd("set number")

--[[
-- Tab Control
]]
-- Number of spaces for <TAB> when editing
vim.opt.softtabstop = 4

-- Insert 4 spaces for a <TAB>
vim.opt.shiftwidth = 4

-- Tabs are spaces
vim.opt.expandtab = true
