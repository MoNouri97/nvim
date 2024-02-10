-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

local copyLineDown = function()
  local mode = vim.api.nvim_get_mode().mode
  local old_reg = vim.fn.getreg("+")
  local old_regtype = vim.fn.getregtype("+")
  if mode == "V" then
    vim.cmd("normal! y'>p")
  else
    vim.cmd("normal! yyp")
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.fn.setreg("+", old_reg, old_regtype)
end

vim.keymap.set({ "n", "v" }, "<C-j>", copyLineDown, { desc = "Copy Line Down" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Exit Edit mode with jk" })
-- Move Lines for mac (cuz mac is special :) & dumb )
vim.keymap.set("n", "Ï", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "È", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "Ï", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "È", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "Ï", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "È", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- hint \"_d :copy to void registry
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste & preserve yanked" })
vim.keymap.set({ "v", "n" }, "<leader>d", '"_d', { desc = "Delete & preserve yanked" })
-- replace word in file
vim.keymap.set(
  "n",
  "<leader>sf",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "find and replace in file" }
)
-- stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- prime git conflict keymaps
vim.keymap.set("n", "gj", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gf", "<cmd>diffget //3<CR>")

map("n", "<C-y>", "<CMD>%y<CR>", { desc = "Yank All" })
-- lazygit
map("n", "<leader>gg", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "single" })
end, { desc = "Lazygit (root dir)" })
