-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
--
vim.keymap.set("i", "jk", "<esc>", { desc = "Exit Edit mode with jk" })
vim.keymap.set("n", "J", "yyp", { desc = "Copy Line Down" })
vim.keymap.set("v", "J", "y'>p", { desc = "Copy Lines Down" })
-- Move Lines for mac (cuz mac is special :) & dumb )
vim.keymap.set("n", "Ï", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "È", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "Ï", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "È", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "Ï", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "È", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- hint \"_d :copy to void registry
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste & preserve yanked" })
vim.keymap.set("v", "<leader>d", '"_dd', { desc = "Delete & preserve yanked" })
vim.keymap.set("n", "<leader>d", '"_dd', { desc = "Delete & preserve yanked" })
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
