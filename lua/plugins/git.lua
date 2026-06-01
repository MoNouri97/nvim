return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      -- current_line_blame_formatter_opts = {
      --   relative_time = true,
      -- },
    },
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = function()
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
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File Git History" },
      {
        mode = { "v" },
        "<leader>gl",
        ":'<,'>DiffviewFileHistory<cr>",
        desc = "Line Git History",
      },
    },
  },
}
