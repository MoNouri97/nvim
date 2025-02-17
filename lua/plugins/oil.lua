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
          -- Get the buffer number of the Oil window
          -- local oil_buf = vim.api.nvim_get_current_buf()
          -- Create buffer-local keymap
          -- vim.keymap.set("n", "q", ":q<CR>", { buffer = oil_buf, silent = true })
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
