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
