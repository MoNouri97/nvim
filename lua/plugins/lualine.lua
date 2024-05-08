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
      { "progress", separator = { right = "" }, padding = { left = 1 } },
    }
  end,
}
