return {
  {
    "tpope/vim-fugitive",
  },
  { "lewis6991/gitsigns.nvim", opts = { current_line_blame = true } },
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = function()
      require("telescope").load_extension("git_worktree")
      return {
        {
          "<leader>gw",
          "<cmd>Telescope git_worktree theme=dropdown<cr>",
          -- function()
          --   require("telescope").extensions.git_worktree.git_worktrees()
          -- end,
          mode = "n",
          desc = "Git Worktrees",
        },
      }
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
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
