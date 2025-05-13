-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- vim.lsp.set_log_level("debug")
vim.lsp.set_log_level("off")

-- colorscheme related
-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("jellybeans")
vim.cmd([[set pumblend=0]])
