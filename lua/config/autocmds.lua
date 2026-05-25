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
-- Create an autogroup for generated buffer management
local generated_buffers = vim.api.nvim_create_augroup("GeneratedBuffers", { clear = true })

-- Auto-close buffers with "**generated**" in the name when leaving them
vim.api.nvim_create_autocmd("BufLeave", {
  group = generated_buffers,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("generated") then
      -- Use vim.schedule to avoid issues with buffer operations during BufLeave
      vim.schedule(function()
        local bufnr = vim.fn.bufnr(bufname)
        if bufnr ~= -1 and vim.api.nvim_buf_is_valid(bufnr) then
          print("removing buffer ...")
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end)
    end
  end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = vim.keymap.set
    map("n", "gd", require("telescope.builtin").lsp_definitions, {
      desc = "Goto Definition",
      buffer = bufnr,
    })
    map("n", "gr", require("telescope.builtin").lsp_references, {
      desc = "Goto References",
      buffer = bufnr,
    })

    map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation", buffer = bufnr })
    map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition", buffer = bufnr })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = bufnr })
    map("n", "K", function()
      return vim.lsp.buf.hover()
    end, { desc = "Hover", buffer = bufnr })
    map("n", "gK", function()
      return vim.lsp.buf.signature_help()
    end, { desc = "Signature Help", buffer = bufnr })
    map("i", "<c-k>", function()
      return vim.lsp.buf.signature_help()
    end, { desc = "Signature Help", buffer = bufnr })
    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
    map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens", buffer = bufnr })
    map("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens", buffer = bufnr })
    map("n", "<leader>cR", function()
      Snacks.rename.rename_file()
    end, { desc = "Rename File", buffer = bufnr })
    map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
    map("n", "<leader>cA", LazyVim.lsp.action.source, { desc = "Source Action", buffer = bufnr })
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
