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
-- FIXME: under test
-- vim.api.nvim_create_autocmd("FocusLost", {
--   callback = function()
--     -- iterate over all listed buffers
--     print("Saving ...")
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--       if
--         vim.api.nvim_buf_is_loaded(buf)
--         and vim.bo[buf].buftype == "" -- only normal files
--         and vim.bo[buf].modifiable -- skip readonly
--         and vim.api.nvim_buf_get_option(buf, "modified")
--       then
--         vim.api.nvim_buf_call(buf, function()
--           vim.cmd("write")
--         end)
--       end
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = LazyVim.lsp.action["source.organizeImports"],
-- })
