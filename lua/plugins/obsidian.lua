return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    keys = {
      {
        "<C-l>",
        function()
          -- Custom toggle using checkbox.order instead of ui.checkboxes
          local toggle = require("obsidian.util").toggle_checkbox
          local states = { " ", "~", "!", ">", "x" }
          toggle(states)
        end,
        desc = "Obsidian Toggle Checkbox",
        mode = { "n", "i" },
      },
      {
        "<C-l>",
        function()
          -- Custom toggle using checkbox.order instead of ui.checkboxes
          local toggle = require("obsidian.util").toggle_checkbox
          local states = { " ", "~", "!", ">", "x" }
          local lines = require("obsidian.util").get_visual_selection()
          if lines then
            for l = lines.csrow, lines.cerow do
              toggle(states, l)
            end
          end
          vim.fn.feedkeys("gv", "n") -- reselect
        end,
        desc = "Obsidian Toggle Checkbox",
        mode = { "v" },
      },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Obsidian Dailies" },
      {
        "<leader>ox",
        function()
          vim.ui.input({ prompt = "Note title: " }, function(title)
            if title then
              vim.cmd("ObsidianExtractNote " .. title)
            end
          end)
        end,
        desc = "Obsidian Extract Note",
        mode = "v",
      },
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = vim.fn.has("macunix") == 1 and "~/Documents/obsidian-vault" or "/mnt/D/Dev/obsidian",
        },
      },
      -- this fixes conflict with render-markdown
      ui = {
        checkboxes = {},
        bullets = {},
        external_link_icon = {},
      },
      notes_subdir = "MemoMeister/tasks",

      daily_notes = {
        folder = "MemoMeister/daily",
      },

      -- see below for full list of options 👇
    },
  },
}
