return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace word in files (Spectre)",
    },
  },
}
