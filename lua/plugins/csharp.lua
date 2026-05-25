if true then
  return {
    -- {
    --   "seblyng/roslyn.nvim",
    --   -- enabled = false,
    --   ---@module 'roslyn.config'
    --   ---@type RoslynNvimConfig
    --   opts = { -- "auto" | "roslyn" | "off"
    --     --
    --     -- - "auto": Does nothing for filewatching, leaving everything as default
    --     -- - "roslyn": Turns off neovim filewatching which will make roslyn do the filewatching
    --     -- - "off": Hack to turn off all filewatching. (Can be used if you notice performance issues)
    --     filewatching = "roslyn",
    --
    --     -- Optional function that takes an array of targets as the only argument. Return the target you
    --     -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
    --     -- Example:
    --     --
    --     -- choose_target = function(target)
    --     --     return vim.iter(target):find(function(item)
    --     --         if string.match(item, "Foo.sln") then
    --     --             return item
    --     --         end
    --     --     end)
    --     -- end
    --     choose_target = function(target)
    --       return vim.iter(target):find(function(item)
    --         if string.match(item, "BoardGame.sln") then
    --           return item
    --         end
    --       end)
    --     end,
    --     extensions = {
    --       razor = {
    --         enabled = false,
    --         config = {},
    --       },
    --     },
    --     -- your configuration comes here; leave empty for default settings
    --   },
    -- },
    {
      "neovim/nvim-lspconfig",
      opts = {
        -- inlay_hints = { enabled = false },
      },
      config = function()
        vim.lsp.enable("roslyn_ls")
        vim.lsp.config("roslyn_ls", {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        })
      end,
    },
    keys = {},
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
end

-- return {
--   { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = { ensure_installed = { "c_sharp" } },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         omnisharp = {
--           handlers = {
--             ["textDocument/definition"] = function(...)
--               return require("omnisharp_extended").handler(...)
--             end,
--           },
--           keys = {
--             {
--               "gd",
--               function()
--                 require("omnisharp_extended").telescope_lsp_definitions()
--               end,
--               desc = "Goto Definition",
--             },
--           },
--           enable_roslyn_analyzers = true,
--           organize_imports_on_format = true,
--           enable_import_completion = true,
--         },
--       },
--     },
--   },
--   {
--     "stevearc/conform.nvim",
--     -- optional = true,
--     opts = {
--       formatters_by_ft = {
--         cs = { "csharpier" },
--       },
--       formatters = {
--         csharpier = {
--           command = "dotnet-csharpier",
--           args = { "--write-stdout" },
--         },
--       },
--     },
--   },
--   -- {
--   --   "neovim/nvim-lspconfig",
--   --   opts = {
--   --     inlay_hints = { enabled = false },
--   --   },
--   -- },
-- }
