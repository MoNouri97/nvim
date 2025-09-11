return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    win = {
      -- border = "rounded",
    },
    spec = {
      { "<leader>r", group = "Run" },
    },
  },
}
