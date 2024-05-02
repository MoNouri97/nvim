return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
    }
    -- +-------------------------------------------------+
    -- | A | B | C                             X | Y | Z |
    -- +-------------------------------------------------+
    opts.sections.lualine_a = { { "mode", separator = { left = "", right = "" } } }
    opts.sections.lualine_y = { "filetype", "encoding" }
    opts.sections.lualine_z = {
      { "progress", separator = "", padding = { left = 0 } },
      { "location", separator = { right = "" }, padding = { left = 0 } },
    }
  end,
}
