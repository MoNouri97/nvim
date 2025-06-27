-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.hlsearch = false
vim.o.foldmethod = "indent"
-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 10

-- Place a column line
vim.opt.colorcolumn = "120"
vim.opt.clipboard = "unnamedplus"
-- lazyvim snacks_animate
vim.g.snacks_animate = false
-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
-- vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_picker = "telescope"
