if true then
  return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
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
        -- {
        --   mode = "n",
        --   "<C-J>",
        --   function()
        --     harpoon:list():prev()
        --   end,
        --   desc = "Harpoon Prev",
        -- },
        -- {
        --   mode = "n",
        --   "<C-K>",
        --   function()
        --     harpoon:list():next()
        --   end,
        --   desc = "Harpoon Next",
        -- },
      }
    end,
  }
end

-- return {
--   "ThePrimeagen/harpoon",
--   branch = "master",
--   keys = function()
--     local mark = require("harpoon.mark")
--     local ui = require("harpoon.ui")
--     return {
--       { "<leader>a", mark.add_file, mode = "n", desc = "add to harpoon" },
--       { "<C-e>", ui.toggle_quick_menu, mode = "n" },
--       {
--         "<leader>&",
--         function()
--           ui.nav_file(1)
--         end,
--         mode = "n",
--         desc = "Harpoon goto 1",
--       },
--       {
--         "<leader>é",
--         function()
--           ui.nav_file(2)
--         end,
--         mode = "n",
--         desc = "Harpoon goto 2",
--       },
--       {
--         '<leader>"',
--         function()
--           ui.nav_file(3)
--         end,
--         mode = "n",
--         desc = "Harpoon goto 3",
--       },
--       {
--         "<leader>'",
--         function()
--           ui.nav_file(4)
--         end,
--         mode = "n",
--         desc = "Harpoon goto 4",
--       },
--       {
--         "<C-k>",
--         function()
--           ui.nav_next()
--         end,
--         mode = "n",
--         desc = "Harpoon next",
--       },
--     }
--   end,
-- }
