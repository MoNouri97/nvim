return {
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
    "habamax/vim-godot",
    lazy = true,
  },
  { "ThePrimeagen/vim-be-good" },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
