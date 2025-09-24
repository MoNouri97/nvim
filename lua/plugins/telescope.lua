-- local Util = require("lazyvim.util")

-- if true then
--   return {}
--   -- return {
--   --   {
--   --     "ibhagwan/fzf-lua",
--   --     opts = function(_, opts)
--   --       opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
--   --         -- preview = false,
--   --         layout_strategy = "horizontal",
--   --         layout_config = {
--   --           -- height = 0.95,
--   --           width = 0.95,
--   --           horizontal = {
--   --             prompt_position = "bottom",
--   --             preview_width = 0.6,
--   --           },
--   --         },
--   --       })
--   --       -- opts.pickers = vim.tbl_deep_extend("force", opts.defaults or {}, {
--   --       --   find_files = {
--   --       --     -- theme = "dropdown",
--   --       --     preview = false,
--   --       --     hidden = true,
--   --       --   },
--   --       -- })
--   --     end,
--   --     keys = {
--   --       { "<leader>ff", Util.pick("find_files", { hidden = true }), desc = "[F]ind [F]iles" },
--   --       { "<leader>fw", Util.pick("grep_string", { hidden = true }), desc = "[F]ind [W]ord" },
--   --     },
--   --   },
--   -- }
-- end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        -- preview = false,
        layout_strategy = "horizontal",
        layout_config = {
          -- height = 0.95,
          width = 0.95,
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.6,
          },
        },
      })
      opts.pickers = vim.tbl_deep_extend("force", opts.defaults or {}, {
        find_files = {
          theme = "dropdown",
          preview = false,
          hidden = true,
        },
      })
    end,
    keys = {
      { "<leader>ff", LazyVim.pick("find_files", { hidden = true }), desc = "[F]ind [F]iles" },
      {
        "<leader>fA",
        LazyVim.pick("find_files", { hidden = true, no_ignore = true }),
        desc = "[F]ind [A]ll files(no_ignore)",
      },
      { "<leader>fw", LazyVim.pick("grep_string", { hidden = true }), desc = "[F]ind [W]ord" },
    },
  },
}
