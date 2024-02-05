return {
  { "oxfist/night-owl.nvim", priority = 1000, lazy = false },
  -- { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
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
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
