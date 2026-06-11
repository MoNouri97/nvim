local opencode_cmd = "opencode --port"
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}
-- this is an ai agent plugin
return {
  "nickjvandyke/opencode.nvim",
  -- version = "*", -- Latest stable release
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
        require("opencode").ask("@this: ", { submit = true })
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
        require("opencode").toggle()
      end,
      mode = { "n" },
      desc = "Start opencode",
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
