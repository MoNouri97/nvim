return {
  { "ThePrimeagen/vim-be-good" },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- filename on top
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
