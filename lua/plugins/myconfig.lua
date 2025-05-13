return {
  -- { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  -- {
  --   "rcarriga/nvim-notify",
  --   enabled = true,
  --   opts = {
  --     background_colour = "#000000",
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.3)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.3)
  --     end,
  --   },
  --   keys = {
  --     { "<leader>uN", "<CMD>Telescope notify<CR>", desc = "Show All Notifications" },
  --   },
  -- },
  { "ThePrimeagen/vim-be-good" },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}
