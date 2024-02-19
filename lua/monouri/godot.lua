local Util = require("lazyvim.util")

local M = {}
local s_last_scene_run = ""
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

-- Run scene
function M.GodtRun(...)
  local scene_name
  if select("#", ...) > 0 and vim.fn.empty(...) == 0 then
    scene_name = vim.fn.substitute(..., "\\.tscn$", "", "")
  else
    scene_name = Util.root.cwd()
  end
  M.GodotRunScene(scene_name)
  -- local cwd = vim.fn.getcwd()
  -- vim.fn.execute("lcd " .. cwd)
end

-- Run arbitrary scene
---@type fun(scene_name:string)
function M.GodotRunScene(scene_name)
  local godot_command = godot .. " " .. vim.fn.shellescape(scene_name)
  local build_command = "dotnet build"
  local cmd = build_command .. " && " .. godot_command .. " && $SHELL"
  s_last_scene_run = scene_name

  Util.terminal.open(
    { "bash", "-c", cmd },
    { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "single" }
  )
end

return M
