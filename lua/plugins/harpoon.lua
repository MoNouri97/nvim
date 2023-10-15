return {
  "ThePrimeagen/harpoon",
  keys = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    return {
      { "<leader>a", mark.add_file, mode = "n", desc = "add to harpoon" },
      { "<C-e>", ui.toggle_quick_menu, mode = "n" },
      {
        "<C-j>",
        function()
          ui.nav_file(1)
        end,
        mode = "n",
        desc = "harpoon goto 1",
      },
      {
        "<C-k>",
        function()
          ui.nav_next()
        end,
        mode = "n",
        desc = "harpoon next",
      },
    }
  end,
}
