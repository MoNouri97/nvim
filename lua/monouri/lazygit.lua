local Util = require("lazyvim.util")

local M = {}

function LazygitEdit(original_buffer)
  -- git current terminal channel
  ---@diagnostic disable-next-line: param-type-mismatch
  local bufnr = vim.fn.bufnr("%")
  local channel_id = vim.fn.getbufvar(bufnr, "terminal_job_id")

  if channel_id == nil then
    print("No terminal job ID found.")
    return
  end

  -- Use <c-o> to copy the relative file path to the system clipboard in Lazygit
  vim.fn.chansend(channel_id, "\15") -- \15 is <c-o>
  -- Give some time for the copy operation to complete
  vim.cmd("sleep 200m")

  -- Close Lazygit
  vim.cmd("close")

  -- Get the copied relative file path from the system clipboard
  local rel_filepath = vim.fn.getreg("+")

  -- Combine with the current working directory to get the full path
  local cwd = Util.root.get()
  local abs_filepath = cwd .. "/" .. rel_filepath

  print("Opening " .. abs_filepath)

  -- focus on the original window
  local winid = vim.fn.bufwinid(original_buffer)
  if winid ~= -1 then
    vim.fn.win_gotoid(winid)
  else
    print("Could not find the original window")
    return
  end

  -- Open the file in a new buffer
  vim.cmd("e " .. abs_filepath)
end

-- Start Lazygit
function M.startLazygit()
  local current_buffer = vim.api.nvim_get_current_buf()
  local float_term = Util.terminal(
    { "lazygit" },
    { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "rounded" }
  )
  local created_buffer = float_term.buf
  -- set the custom keymap for "<c-i>" within it
  vim.api.nvim_buf_set_keymap(
    created_buffer,
    "t",
    "<s-e>",
    string.format([[<Cmd>lua LazygitEdit(%d)<CR>]], current_buffer),
    { noremap = true, silent = true }
  )
end

return M
