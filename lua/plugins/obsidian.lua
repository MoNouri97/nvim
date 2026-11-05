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
    "obsidian-nvim/obsidian.nvim",
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
    keys = {
      -- cycles through checkbox.order
      { "<C-l>", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Obsidian Toggle Checkbox", mode = { "n", "i" } },
      {
        "<C-l>",
        function()
          vim.cmd("Obsidian toggle_checkbox")
          vim.fn.feedkeys("gv", "n") -- reselect
        end,
        desc = "Obsidian Toggle Checkbox",
        mode = { "v" },
      },
      { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
      { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Obsidian Dailies" },
      { "<leader>ot", "<cmd>Obsidian template todo<cr>", desc = "Obsidian Todo Template" },
      {
        "<leader>ox",
        function()
          vim.ui.input({ prompt = "Note title: " }, function(title)
            if title then
              vim.cmd("Obsidian extract_note " .. title)
            end
          end)
        end,
        desc = "Obsidian Extract Note",
        mode = "v",
      },
    },
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "work",
          path = vim.fn.has("macunix") == 1 and "~/Documents/obsidian-vault" or "/mnt/D/Dev/obsidian",
        },
      },
      -- render-markdown handles rendering
      ui = { enable = false },
      picker = {
        name = "snacks.picker",
      },
      checkbox = {
        order = { " ", "~", "x" },
      },

      notes_subdir = "MemoMeister/tasks",

      daily_notes = {
        folder = "MemoMeister/daily",
        template = "todo.md",
      },

      templates = {
        folder = "MemoMeister/templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          weekday = function()
            return tostring(os.date("%A"))
          end,
        },
      },

      -- see below for full list of options 👇
    },
  },
}
