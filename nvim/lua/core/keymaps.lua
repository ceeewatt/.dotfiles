-- Map the leader key. The lazy plugin manager expects
--  the leader key to be spacebar and the local leader
--  to be '\\'.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
