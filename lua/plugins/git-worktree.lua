return {
  "ThePrimeagen/git-worktree.nvim",
  keys = function()
    return {
      {
        "<leader>gw",
        function()
          require('telescope').extensions.git_worktree.git_worktrees();
        end,
        mode = "n",
        desc = "Git Worktrees"
      },
    }
  end,

}
