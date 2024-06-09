-- this is when using lazyvim extra omnisharp
if true then
  return {
    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
      },
    },
    {
      "stevearc/conform.nvim",
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
end

return {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "csharpier", "netcoredbg" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   -- opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "omnisharp") end,
  --   opts = function(_, opts)
  --     if not opts.ensure_installed then
  --       opts.ensure_installed = {}
  --     end
  --     table.insert(opts.ensure_installed, "csharp_ls")
  --     opts.inlay_hints = {
  --       enabled = false,
  --       exclude = {}, -- filetypes for which you don't want to enable inlay hints
  --     }
  --   end,
  -- },
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
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = false },
  --   },
  -- },
}
