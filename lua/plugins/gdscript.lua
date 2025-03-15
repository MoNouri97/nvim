-- Disable treesitter indent for gdscript
vim.api.nvim_create_autocmd("FileType", {
  desc = "gdscript indent",
  pattern = "gdscript",
  callback = function()
    require("monouri.gdscript").setup()
  end,
})
-- require("monouri.godot-gutter").setup()
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        gdscript = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "gdscript", "godot_resource", "gdshader" },
      indent = {
        enable = true,
        disable = { "gdscript" },
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = false },
  --   },
  -- },
}
