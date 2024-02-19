local Util = require("lazyvim.util")

local M = {}
local s_last_scene_run = ""
-- local godot = os.getenv("godot")
local godot =
  "/home/mono/.local/share/godot/app_userdata/Godots/versions/Godot_v4_3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux.x86_64"

-- Run last scene
function M.GodotRunLast()
  if s_last_scene_run == "" then
    print("No scene was run yet!\n")
    return
  end
  M.GodotRunScene(s_last_scene_run)
end

-- Run current scene
-- function godot_run_current()
--   local scene_name = godot_find_scene_name()
--   godot_run_scene(scene_name)
-- end

-- Run scene
function M.GodtRun(...)
  local cwd = vim.fn.getcwd()
  local scene_name
  if select("#", ...) > 0 and vim.fn.empty(...) == 0 then
    scene_name = vim.fn.substitute(..., "\\.tscn$", "", "")
  else
    scene_name = Util.root.cwd()
  end
  M.GodotRunScene(scene_name)
  vim.fn.execute("lcd " .. cwd)
end

-- Run arbitrary scene
---@type fun(scene_name:string)
function M.GodotRunScene(scene_name)
  -- if not vim.g.godot_executable then
  --   if vim.fn.executable("godot") == 1 then
  --     vim.g.godot_executable = "godot"
  --   elseif vim.fn.executable("godot.exe") == 1 then
  --     vim.g.godot_executable = "godot.exe"
  --   else
  --     vim.api.nvim_err_writeln("Unable to find Godot executable, please specify g:godot_executable")
  --     return
  --   end
  -- end

  local godot_command = godot .. " " .. vim.fn.shellescape(scene_name)
  s_last_scene_run = scene_name

  vim.fn.system(godot_command)
  -- if vim.fn.exists(":AsyncRun") == 1 then
  --   vim.fn("asyncrun#run")
  -- elseif vim.fn.has("win32") == 1 and vim.fn.has("nvim") == 1 then
  --   vim.fn.system("start " .. godot_command)
  -- elseif vim.fn.executable("cmd.exe") == 1 and not vim.fn.exists("$TMUX") then
  --   vim.fn.system("cmd.exe /c start " .. godot_command)
  -- elseif vim.fn.exists(":Spawn") == 1 then
  --   vim.fn.execute("Spawn " .. godot_command)
  -- elseif vim.fn.has("mac") == 1 then
  --   vim.fn.system("open " .. godot_command)
  -- else
  --   vim.fn.system(godot_command)
  -- end
end

return M
