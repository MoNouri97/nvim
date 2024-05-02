return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
    }
    opts.sections.lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } }
    opts.sections.lualine_y = { "filetype", "encoding" }
    opts.sections.lualine_z = {
      { "progress", separator = "", padding = { left = 0 } },
      { "location", separator = { right = "" }, padding = { left = 0 } },
    }
    opts.inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    }
  end,
}
