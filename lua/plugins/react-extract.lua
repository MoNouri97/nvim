return {
  "napmn/react-extract.nvim",
  keys = function()
    local re = require("react-extract")

    return {
      { mode = "v", "<leader>rc", re.extract_to_current_file, desc = "Extract component" },
      { mode = "v", "<leader>re", re.extract_to_new_file, desc = "Extract component to file" },
    }
  end,
}
