-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- load snippets from path/of/your/nvim/config/vsc
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vsc" } })
vim.lsp.set_log_level("debug")
