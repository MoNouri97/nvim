return {
  -- { "wilmanbarrios/palenight.nvim", lazy = false, priority = 1000, name = "palenight" },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italics = true,
      flat_ui = true, -- toggles "flat UI" for pickers
      background = {
        dark = "jellybeans", -- default dark palette
        light = "jellybeans_light", -- default light palette
      },
      plugins = {
        all = false,
        auto = true, -- will read lazy.nvim and apply the colors for plugins that are installed
      },
      -- on_highlights = function(highlights, colors) end,
      -- on_colors = function(colors) end,
    }, -- Optional
  },
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
        fzf = true,
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
        telescope = {
          enabled = true,
          -- style = "nvchad",
        },
        treesitter = true,
        which_key = true,
      },
      highlight_overrides = {
        all = function(C)
          -- add flat style telescope since it was removed from catppuccin
          return {
            TelescopeBorder = {
              fg = C.mantle,

              bg = C.mantle,
            },
            TelescopePromptBorder = {
              fg = C.surface0,
              bg = C.surface0,
            },
            TelescopePromptNormal = {
              fg = C.text,
              bg = C.surface0,
            },
            TelescopePromptPrefix = {
              fg = C.flamingo,
              bg = C.surface0,
            },
            TelescopeNormal = {
              bg = C.mantle,
            },
            TelescopePreviewTitle = {
              fg = C.base,
              bg = C.green,
            },
            TelescopePromptTitle = {
              fg = C.base,
              bg = C.red,
            },
            TelescopeResultsTitle = {
              fg = C.mantle,
              bg = C.lavender,
            },
            TelescopeSelection = {
              fg = C.text,
              bg = C.surface0,
            },
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
      no_italic = true, -- Force no italic
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- {
  --   "oxfist/night-owl.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     -- These are the default settings
  --     bold = true,
  --     italics = true,
  --     underline = true,
  --     undercurl = true,
  --   },
  -- },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = function()
  --     return {
  --       transparent = false,
  --     }
  --   end,
  -- },
}
