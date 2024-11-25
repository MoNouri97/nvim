-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
--
-- Auto Save
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  callback = function()
    print("Saving ...")
    vim.cmd("wa")
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = LazyVim.lsp.action["source.organizeImports"],
-- })
