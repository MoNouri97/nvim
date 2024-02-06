local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        -- preview = false,
        layout_strategy = "horizontal",
        layout_config = {
          -- height = 0.95,
          -- width = 0.95,
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
        },
        git_files = {
          theme = "dropdown",
          preview = false,
        },
      })
    end,
  },
}
