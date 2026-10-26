return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local harpoon = require("harpoon")

    local toggle_opts = {
      border = "rounded",
      title_pos = "center",
      ui_width_ratio = 0.40,
    }

    local function toggle_picker(harpoon_files)
      local items = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(items, {
          text = vim.fn.fnamemodify(item.value, ":~"),
          file = item.value,
        })
      end

      Snacks.picker.pick({
        title = "Harpoon",
        items = items,
        format = "file",
      })
    end

    return {
      {
        mode = "n",
        "<leader>a",
        function()
          harpoon:list():add()
        end,
        desc = "[A]dd to harpoon",
      },
      {
        mode = "n",
        "<leader>A",
        function()
          harpoon:list():prepend()
        end,
        desc = "[A]dd to harpoon In Front",
      },
      {
        mode = "n",
        "<C-e>",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end,
        desc = "Harpoon menu",
      },
      {
        mode = "n",
        "<leader>(",
        function()
          toggle_picker(harpoon:list())
        end,
        desc = "Harpoon picker menu",
      },
      {
        mode = "n",
        "<leader>&",
        function()
          harpoon:list():select(1)
        end,
        desc = "Harpoon [1]",
      },
      {
        mode = "n",
        "<leader>é",
        function()
          harpoon:list():select(2)
        end,
        desc = "Harpoon [2]",
      },
      {
        mode = "n",
        '<leader>"',
        function()
          harpoon:list():select(3)
        end,
        desc = "Harpoon [3]",
      },
      {
        mode = "n",
        "<leader>'",
        function()
          harpoon:list():select(4)
        end,
        desc = "Harpoon [4]",
      },

      -- Toggle previous & next buffers stored within Harpoon list
      {
        mode = "n",
        "<leader>j",
        function()
          harpoon:list():prev({ ui_nav_wrap = true })
        end,
        desc = "Harpoon Prev",
      },
      {
        mode = "n",
        "<leader>k",
        function()
          harpoon:list():next({ ui_nav_wrap = true })
        end,
        desc = "Harpoon Next",
      },
    }
  end,
}
