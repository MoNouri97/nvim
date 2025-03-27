---@diagnostic disable: need-check-nil
local Util = require("lazyvim.util")
local Snacks = require("snacks")

local M = {}
local s_last_scene_run = ""
local godot = nil
-- Ask & Save Godot Path
-- File to store the paths
local config_dir = vim.fn.stdpath("cache")
local cache_file = config_dir .. "/saved_paths.json"

-- Function to load saved paths from the file
local function load_saved_paths()
  -- Create an empty table if file doesn't exist
  if vim.fn.filereadable(cache_file) == 0 then
    return {}
  end

  local file = io.open(cache_file, "r")
  if not file then
    return {}
  end

  local content = file:read("*all")
  file:close()

  -- Return empty table if file is empty
  if content == "" then
    return {}
  end

  -- Parse JSON content
  local ok, paths = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Error loading saved paths: " .. paths, vim.log.levels.ERROR)
    return {}
  end

  return paths
end

-- Function to save paths to the file
local function save_paths(paths)
  local file = io.open(cache_file, "w")
  if not file then
    vim.notify("Error: Couldn't open file for writing", vim.log.levels.ERROR)
    return false
  end

  local ok, json = pcall(vim.json.encode, paths)
  if not ok then
    vim.notify("Error encoding paths to JSON", vim.log.levels.ERROR)
    file:close()
    return false
  end

  file:write(json)
  file:close()
  return true
end

-- Get current working directory
local function get_cwd()
  return vim.fn.getcwd()
end

---Add the godot bin path for the current_dir
---@param func? function
function SavePathForCurrentDirectory(func)
  -- Get current working directory
  local current_dir = get_cwd()

  -- Ask the user for a path input
  vim.ui.input({
    prompt = "Enter path for Godot: ",
    completion = "file", -- Enables file path completion
  }, function(input)
    -- Check if the user provided input or cancelled
    if input then
      -- Load existing paths
      local paths = load_saved_paths()

      -- Initialize the directory entry if it doesn't exist
      if not paths[current_dir] then
        paths[current_dir] = {}
      end

      -- Add path with timestamp
      paths[current_dir] = {
        path = input,
        timestamp = os.time(),
      }

      -- Save to file
      if save_paths(paths) then
        if func ~= nil then
          func(input)
        end
        vim.notify("Path saved for " .. current_dir .. ": " .. input, vim.log.levels.INFO)
      end
    else
      vim.notify("Path input cancelled", vim.log.levels.WARN)
    end
  end)
end

function GetCurrentSavedPath()
  local current_dir = get_cwd()
  local paths = load_saved_paths()
  if paths[current_dir] and paths[current_dir].path then
    local saved = paths[current_dir]
    return saved.path
  end
  return nil
end
-- Function to display the path for the current directory
function DisplayPathForCurrentDirectory()
  local current_dir = get_cwd()
  local paths = load_saved_paths()

  if paths[current_dir] and paths[current_dir].path then
    local saved = paths[current_dir]
    -- Format the timestamp
    local time_str = os.date("%Y-%m-%d %H:%M:%S", saved.timestamp)
    vim.notify("Path for " .. current_dir .. ":\n" .. saved.path .. "\nSaved on: " .. time_str, vim.log.levels.INFO)
  else
    vim.notify("No path saved for " .. current_dir, vim.log.levels.WARN)
  end
end

-- Function to list all saved directory-path mappings
function ListAllSavedPaths()
  local paths = load_saved_paths()

  if vim.tbl_isempty(paths) then
    vim.notify("No paths have been saved yet", vim.log.levels.WARN)
    return
  end

  local lines = { "Saved paths for directories:" }
  for dir, data in pairs(paths) do
    local time_str = os.date("%Y-%m-%d %H:%M:%S", data.timestamp)
    table.insert(lines, string.format("\n%s\n  → %s\n  [Saved: %s]", dir, data.path, time_str))
  end

  vim.notify(table.concat(lines, ""), vim.log.levels.INFO)
end

-- Create user commands
vim.api.nvim_create_user_command("SaveDirPath", SavePathForCurrentDirectory, {})
vim.api.nvim_create_user_command("ShowDirPath", DisplayPathForCurrentDirectory, {})
vim.api.nvim_create_user_command("ListAllDirPaths", ListAllSavedPaths, {})

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

-- Choose & Run scene
function M.Choose()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Find all .tscn files
  local handle = io.popen('find . -name "*.tscn" | sort')
  local result = handle:read("*a")
  handle:close()

  -- Split the result into a table of filenames
  local files = {}
  for filename in string.gmatch(result, "[^\n]+") do
    table.insert(files, filename)
  end

  if #files == 0 then
    vim.notify("No .tscn files found", vim.log.levels.WARN)
    return
  end

  -- Create the picker
  pickers
    .new({}, {
      prompt_title = "Scene Files",
      finder = finders.new_table({
        results = files,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          M.GodotRunScene(selection.value)
        end)
        return true
      end,
    })
    :find()
end

-- Run arbitrary scene
---@type fun(scene_name:string)
function M.GodotRunScene(scene_name)
  godot = GetCurrentSavedPath()
  if godot == nil then
    SavePathForCurrentDirectory(function()
      M.GodotRunScene(scene_name)
    end)
    return
  end
  local godot_command = godot .. " " .. vim.fn.shellescape(scene_name)
  local build_command = "dotnet build"
  local cmd = build_command .. " && " .. godot_command .. " && $SHELL"
  s_last_scene_run = scene_name

  Snacks.terminal({ "bash", "-c", cmd }, { cwd = Util.root(), auto_close = true })
end

return M
