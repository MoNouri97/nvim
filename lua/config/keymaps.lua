-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- This file is automatically loaded by lazyvim.config.init
local lazygit = require("monouri.lazygit")
local godot = require("monouri.godot")

local map = vim.keymap.set

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
-- hint \"_d :copy to void registry (thx prime)
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste & preserve yanked" })
vim.keymap.set({ "v", "n" }, "<leader>d", '"_d', { desc = "Delete & preserve yanked" })
-- replace word in file
vim.keymap.set(
  "n",
  "<leader>fa",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[F]ind [A]nd replace in file" }
)
-- stay centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "G", "Gzz")
map("n", "*", "*zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "%", "%zz")
-- prime git conflict keymaps
vim.keymap.set("n", "gj", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gf", "<cmd>diffget //3<CR>")

map("n", "<C-y>", "<CMD>%y<CR>", { desc = "Yank All" })
-- lazygit
map("n", "<leader>gg", lazygit.startLazygit, { noremap = true, silent = true, desc = "Lazygit (root dir)" })

-- godot
map("n", "<leader>rg", godot.GodtRun, { desc = "[R]un [G]odot Projet" })

-- oil
map("n", "<leader>-", function()
  require("oil").toggle_float()
end, { desc = "Oil File Explorer" })
