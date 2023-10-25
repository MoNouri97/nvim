return {
  { "nvimtools/none-ls.nvim", enabled = false },
  { "stevearc/conform.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
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
        gdscript = {},
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.3)
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      -- transparent = true,
      -- styles = {
      --   -- Background styles. Can be "dark", "transparent" or "normal"
      --   sidebars = "transparent", -- style for sidebars, see below
      --   floats = "transparent", -- style for floating windows
      -- },
    },
  },
  {
    "habamax/vim-godot",
    lazy = true,
  },
  { "ThePrimeagen/vim-be-good" },
}
