-- Map the leader key. The lazy plugin manager expects
--  the leader key to be spacebar and the local leader
--  to be '\\'.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Focus window right" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Focus window up" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Focus window down" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Focus window left" })

vim.keymap.set("n", "<leader>L", "<C-w>L", { desc = "Move window right" })
vim.keymap.set("n", "<leader>K", "<C-w>K", { desc = "Move window up" })
vim.keymap.set("n", "<leader>J", "<C-w>J", { desc = "Move window down" })
vim.keymap.set("n", "<leader>H", "<C-w>H", { desc = "Move window left" })
