return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "csharpier")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    -- optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "omnisharp") end,
    opts = function(_, opts)
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end
      table.insert(opts.ensure_installed, "csharp_ls")
    end,
  },
  {
    "stevearc/conform.nvim",
    -- optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
}
