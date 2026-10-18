if true then
  return {
    "nickjvandyke/opencode.nvim",
    -- dir = "~/Dev/opencode.nvim",
    -- version = "*", -- Latest stable release only supports v1
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }

      -- Optionally show upon submitting prompt
      vim.api.nvim_create_autocmd("User", {
        pattern = { "OpencodeEvent:tui.command.execute" },
        callback = function(args)
          ---@type opencode.server.Event
          local event = args.data.event
          if event.properties.command == "prompt.submit" then
            local win = require("snacks.terminal").get(opencode_cmd, { create = false })
            if win then
              win:show()
            end
          end
        end,
      })

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
    keys = {
      {
        "<C-a>",
        function()
          require("opencode").ask("@this: ", { session = "new" })
        end,
        mode = { "n", "x" },
        desc = "Ask opencode…",
      },
      {
        "<C-x>",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Execute opencode action…",
      },
      {
        "<leader>oo",
        function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
        mode = { "n" },
        desc = "Start opencode",
      },
      {
        "<leader>ow",
        function()
          require("opencode").ask(
            "Summarize my last week of work from MemoMeister/daily/ — list each day with key tasks, flag unfinished items, and identify recurring themes (e.g., animations, Sentry, build CI). Keep it brief, 5–10 lines max."
          )
        end,
        mode = { "n" },
        desc = "Weekly Summary",
      },
      {
        "<A-;>",
        function()
          -- Can also leverage toggle functionality.
          -- Avoid <leader> here — Neovim watches for keymaps in terminal mode, so your leader key will have input delay.
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
        mode = { "n", "t" },
        desc = "Toggle opencode",
      },
      {
        "<leader>o",
        function()
          return require("opencode").operator("@this ")
        end,
        mode = { "n", "v" },
        desc = "Add range to opencode",
        expr = true,
      },
      {
        "<leader>ol",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        mode = "n",
        desc = "Add line to opencode",
        expr = true,
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command("session.half.page.up")
        end,
        mode = "n",
        desc = "Scroll opencode up",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command("session.half.page.down")
        end,
        mode = "n",
        desc = "Scroll opencode down",
      },
    },
  }
end

-- return {
--   "sudo-tee/opencode.nvim",
--   event = "VeryLazy",
--   config = function()
--     require("opencode").setup({
--       keymap = {
--         editor = {
--           -- Mirror the bindings from the previous nickjvandyke/opencode.nvim setup
--           ["<C-a>"] = { "open_input", mode = { "n", "x" }, desc = "Ask opencode…" },
--           ["<C-x>"] = { "select_history", mode = { "n", "x" }, desc = "Select opencode prompt…" },
--           ["<leader>oo"] = { "toggle", desc = "Toggle opencode" },
--           ["<A-;>"] = { "toggle", desc = "Toggle opencode" },
--           ["<leader>oO"] = { "open_output", desc = "Open output window" },
--         },
--       },
--     })
--   end,
--   keys = {
--     {
--       "<leader>ow",
--       function()
--         require("opencode.api").run(
--           "Summarize my last week of work from MemoMeister/daily/ — list each day with key tasks, flag unfinished items, and identify recurring themes (e.g., animations, Sentry, build CI). Keep it brief, 5–10 lines max."
--         )
--       end,
--       mode = "n",
--       desc = "Weekly Summary",
--     },
--   },
--   dependencies = {
--     {
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         anti_conceal = { enabled = false },
--         file_types = { "markdown", "opencode_output" },
--       },
--       ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
--     },
--     -- Optional, for file mentions and commands completion, pick only one
--     "saghen/blink.cmp",
--     "hrsh7th/nvim-cmp",
--
--     -- Optional, for file mentions picker, pick only one
--     "folke/snacks.nvim",
--     -- 'nvim-telescope/telescope.nvim',
--     -- 'ibhagwan/fzf-lua',
--     -- 'nvim_mini/mini.nvim',
--   },
-- }
