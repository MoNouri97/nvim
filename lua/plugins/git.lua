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
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>gw",
        function()
          local items = {}
          local entry = {}
          local function flush()
            if entry.worktree then
              local branch = entry.branch and entry.branch:gsub("^refs/heads/", "") or "detached"
              items[#items + 1] = {
                text = ("%s  %s"):format(vim.fn.fnamemodify(entry.worktree, ":~"), branch),
                file = entry.worktree,
              }
            end
            entry = {}
          end
          for _, line in ipairs(vim.fn.systemlist({ "git", "worktree", "list", "--porcelain" })) do
            if line == "" then
              flush()
            else
              local key, value = line:match("^(%S+)%s*(.*)$")
              if key then
                entry[key] = value
              end
            end
          end
          flush()

          Snacks.picker.pick({
            title = "Git Worktrees",
            items = items,
            format = "text",
            layout = { preset = "select" },
            confirm = function(picker, item)
              picker:close()
              if item then
                require("git-worktree").switch_worktree(item.file)
              end
            end,
          })
        end,
        mode = "n",
        desc = "Git Worktrees",
      },
    },
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
