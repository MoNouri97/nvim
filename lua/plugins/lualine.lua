local Util = require("lazyvim.util.lualine")
--
local get_full_path = function(root_dir, value)
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return root_dir .. "\\" .. value
  end

  return root_dir .. "/" .. value
end

local is_relative_path = function(path)
  return string.sub(path, 1, 1) ~= "/"
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local harpoon_list = require("harpoon"):list()
    local function harpoon_component()
      local total_marks = harpoon_list:length()
      local root_dir = harpoon_list.config:get_root_dir()
      local current_file_path = vim.api.nvim_buf_get_name(0)

      if total_marks == 0 then
        return ""
      end

      -- local current_mark = "—"
      local current_mark = "-"

      for i = 1, total_marks do
        local harpoon_entry = harpoon_list:get(i)
        if not harpoon_entry then
          return
        end
        local harpoon_path = harpoon_entry.value

        local full_path = nil
        if is_relative_path(harpoon_path) then
          full_path = get_full_path(root_dir, harpoon_path)
        else
          full_path = harpoon_path
        end

        if full_path == current_file_path then
          current_mark = tostring(i)
        end
      end

      return string.format("󰀱 %s/%d", current_mark, total_marks)
    end

    opts.options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
    }
    -- +-------------------------------------------------+
    -- | A | B | C                             X | Y | Z |
    -- +-------------------------------------------------+
    -- opts.sections.lualine_a = { { "mode", separator = { left = "", right = "" } } }
    opts.sections.lualine_a = { { "mode", separator = { left = "█", right = "" } } }
    opts.sections.lualine_c = { harpoon_component, Util.pretty_path() }
    opts.sections.lualine_y = { "filetype" }
    opts.sections.lualine_z = {
      -- { "encoding", separator = { left = "", right = "█" }, padding = { left = 1 } },
      { "encoding", separator = { left = "", right = "█" }, padding = { left = 1 } },
    }
  end,
}
