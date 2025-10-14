return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          root_dir = require("lspconfig.util").root_pattern("tsconfig.json")(),
          root_markers = { "tsconfig.json", ".git" },
        },
      },
    },
  },
}
