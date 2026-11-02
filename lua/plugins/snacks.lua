return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>fA",
        LazyVim.pick("find_files", { hidden = true, no_ignore = true }),
        desc = "[F]ind [A]ll files(no_ignore)",
      },
      {
        "<leader>fw",
        LazyVim.pick("grep_word", { hidden = true }),
        desc = "[F]ind [W]ord",
      },
      -- {
      --   "<leader>fp",
      --   function()
      --     Snacks.picker.files({ cwd = require("lazy.core.config").options.root })
      --   end,
      --   desc = "Find Plugin File",
      -- },
    },
  },
}
