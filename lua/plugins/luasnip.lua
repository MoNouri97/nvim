return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vsc" } })
    end,
  },
}
