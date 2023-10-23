-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
--
vim.keymap.set("i", "jk", "<esc>", { desc = "Exit Edit mode with jk" })
vim.keymap.set("n", "J", "yyp", { desc = "Copy Line Down" })
vim.keymap.set("v", "J", "y'>p", { desc = "Copy Lines Down" })
-- hint \"_d :copy to void registry
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste & preserve yanked" })
vim.keymap.set("v", "<leader>d", '"_dd', { desc = "Delete & preserve yanked" })
vim.keymap.set("n", "<leader>d", '"_dd', { desc = "Delete & preserve yanked" })
-- replace word in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
