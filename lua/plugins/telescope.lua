-- Telescope is replaced by the Snacks picker.
-- `vim.g.lazyvim_picker = "snacks"` plus the `editor.snacks_picker` extra make
-- Snacks the picker used by `LazyVim.pick`, and all explicit Telescope usages
-- (harpoon, C# LSP, git worktrees, plugin files) were migrated to Snacks.
-- See `lua/plugins/snacks.lua`.
return {
  { "nvim-telescope/telescope.nvim", enabled = false },
}
