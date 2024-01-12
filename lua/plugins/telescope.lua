local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.95,
          width = 0.95,
          horizontal = {
            preview_width = 0.6,
          },
        },
      })
    end,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    keys = {
      { "<leader>gS", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced Git Search" },
      { "<leader>gf", "<cmd>AdvancedGitSearch diff_commit_file<cr>", desc = "File Git History" },
      {
        mode = { "v" },
        "<leader>gl",
        "<cmd>'<,'>AdvancedGitSearch diff_commit_line<cr>",
        desc = "Line Git History",
      },
    },
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup({
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            show_builtin_git_pickers = false,
            entry_default_author_or_date = "author", -- one of "author" or "date"
            -- Telescope layout setup
            telescope_theme = {
              show_custom_functions = "dropdown",
              -- e.g. realistic example
              -- show_custom_functions = {
              --   layout_config = { width = 0.4, height = 0.4 },
              -- },
            },
          },
        },
      })
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
