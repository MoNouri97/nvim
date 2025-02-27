-- q to quick & enter to change file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    local oil_buf = vim.api.nvim_get_current_buf()
    vim.opt_local.colorcolumn = ""
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "<CR>", function()
      -- Get the selected file path from Oil
      local oil = require("oil")
      local entry = oil.get_cursor_entry()

      if entry and entry.type ~= "directory" then
        -- Open the file
        oil.select()
        -- Close any other splits except the main one and oil
        vim.cmd("only")
      else
        -- If it's a directory, just use default Oil behavior
        oil.select()
      end
    end, { buffer = oil_buf, silent = true })
  end,
})

-- Auto-close oil when leaving the buffer
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function(ev)
    local filetype = vim.bo[ev.buf].filetype
    local ft = "oil"
    if filetype == ft then
      -- Use vim.defer_fn to avoid issues with autocmd execution context
      vim.defer_fn(function()
        -- Only close if buffer still exists and matches our filetype
        if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == ft then
          vim.cmd("silent! bd " .. ev.buf)
        end
      end, 10)
    end
  end,
  desc = "Auto-close specific filetypes when leaving buffer",
})

return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>e",
        function()
          vim.cmd("vsplit | wincmd r | vertical resize 30")
          require("oil").open()
        end,
        desc = "Side Oil",
      },
    },
    config = function()
      require("oil").setup({
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-\\>"] = "actions.select_vsplit",
          ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["q"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
