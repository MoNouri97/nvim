return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      border = "rounded",
    },
    defaults = {
      ["<leader>r"] = { name = "Run" },
      -- ["<leader>fa"] = { name = "Find And" },
    },
  },
}
