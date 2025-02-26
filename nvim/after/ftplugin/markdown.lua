vim.cmd("setlocal wrap")
vim.cmd("setlocal linebreak")
-- vim.cmd("setlocal spell")

-- For navigating visual lines: https://neovim.io/doc/user/usr_25.html#_breaking-at-words
vim.keymap.set({ "n", "o", "x" }, "j", "gj", {})
vim.keymap.set({ "n", "o", "x" }, "k", "gk", {})
vim.keymap.set({ "n", "o", "x" }, "0", "g0", {})
vim.keymap.set({ "n", "o", "x" }, "$", "g$", {})
