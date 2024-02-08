return {
  "ThePrimeagen/harpoon",
  keys = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    return {
      { "<leader>a", mark.add_file, mode = "n", desc = "add to harpoon" },
      { "<C-e>", ui.toggle_quick_menu, mode = "n" },
      {
        "<leader>&",
        function()
          ui.nav_file(1)
        end,
        mode = "n",
        desc = "Harpoon goto 1",
      },
      {
        "<leader>é",
        function()
          ui.nav_file(2)
        end,
        mode = "n",
        desc = "Harpoon goto 2",
      },
      {
        '<leader>"',
        function()
          ui.nav_file(3)
        end,
        mode = "n",
        desc = "Harpoon goto 3",
      },
      {
        "<leader>'",
        function()
          ui.nav_file(4)
        end,
        mode = "n",
        desc = "Harpoon goto 4",
      },
      {
        "<C-k>",
        function()
          ui.nav_next()
        end,
        mode = "n",
        desc = "Harpoon next",
      },
    }
  end,
}
