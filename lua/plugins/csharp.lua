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
  pattern = "cs",
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    vim.lsp.enable("roslyn_ls")
    vim.lsp.config("roslyn_ls", {
      -- ["csharp|background_analysis"] = {
      --   dotnet_analyzer_diagnostics_scope = "openFiles",
      --   dotnet_compiler_diagnostics_scope = "openFiles",
      -- },
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
    })
  end,
})


return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "csharpier",
          args = { "format", "--write-stdout" },
          to_stdin = true,
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = true,
    opts = function(_, opts)
      opts.sources = {}
      -- local nls = require("null-ls")
      -- table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
}
