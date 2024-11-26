return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
      },
      integrations = {
        grug_far = true,
        harpoon = true,
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        -- telescope = true,
        telescope = {
          enabled = true,
          -- style = "nvchad",
        },
        treesitter = true,
        which_key = true,
      },
      highlight_overrides = {
        all = function(colors)
          return {
            -- DiagnosticVirtualTextError = { bg = colors.none },
            -- DiagnosticVirtualTextWarn = { bg = colors.none },
            -- DiagnosticVirtualTextHint = { bg = colors.none },
            -- DiagnosticVirtualTextInfo = { bg = colors.none },
            -- Pmenu = { bg = colors.none },
            -- Normal = { bg = colors.none },
            -- NormalFloat = { bg = colors.none },
            -- NeoTreeNormalFloat = { bg = colors.none },
          }
        end,
      },
      color_overrides = {
        mocha = {
          -- base = "#000000",
          -- mantle = "#000000",
          -- crust = "#000000",
          -- I don't think these colours are pastel enough by default!
          peach = "#fcc6a7",
          green = "#d2fac5",
        },
      },
      no_italic = false, -- Force no italic
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = { "italic" },
        keywords = {},
        strings = { "italic" },
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
    },
  },
  {
    "oxfist/night-owl.nvim",
    enabled = false,
    priority = 1000,
    lazy = false,
    opts = {
      -- These are the default settings
      bold = true,
      italics = true,
      underline = true,
      undercurl = true,
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = false,
      }
    end,
  },
}
