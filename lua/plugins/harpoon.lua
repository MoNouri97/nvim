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
    local conf = require("telescope.config").values

    local toggle_opts = {
      border = "rounded",
      title_pos = "center",
      ui_width_ratio = 0.40,
    }

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
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
          toggle_telescope(harpoon:list())
        end,
        desc = "Harpoon telescope menu",
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
