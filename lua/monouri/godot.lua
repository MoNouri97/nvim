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

-- save path or create and then save
local function save_or_create(input, current_dir)
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
    return true
  end
end

-- Get current working directory
local function get_cwd()
  return vim.fn.getcwd()
end

-- Get the godot version
-- Example usage
-- local version = get_godot_version_from_csproj()
local function get_godot_version_from_csproj()
  local cwd = get_cwd()
  -- find all *.csproj files in current directory
  local files = vim.fn.globpath(cwd, "*.csproj", false, true)

  if #files == 0 then
    print("No .csproj files found in " .. cwd)
    return nil
  end

  -- just use the first .csproj file found
  local filepath = files[1]

  local lines = vim.fn.readfile(filepath)
  if #lines == 0 then
    print("Empty .csproj file: " .. filepath)
    return nil
  end
  -- Look for version in the first line (or fallback to scanning all lines)
  local first_line = lines[1]
  local version = string.match(first_line, 'Sdk="Godot%.NET%.Sdk/(.-)"')

  if not version then
    -- fallback: scan entire file
    for _, line in ipairs(lines) do
      version = string.match(line, 'Sdk="Godot%.NET%.Sdk/(.-)"')
      if version then
        break
      end
    end
  end

  if version then
    print("Godot .NET SDK version: " .. version)
    return version
  else
    print("Could not find Godot .NET SDK version in .csproj")
    return nil
  end
end
-- recursive search for an executable inside a folder
local function search_for_executable(folder, exe_prefix)
  -- check all files directly in this folder
  local files = vim.fn.glob(folder .. "/*", false, true)

  for _, path in ipairs(files) do
    if vim.fn.isdirectory(path) == 1 then
      -- only recurse into subdirs that also match the exe prefix
      local fname = vim.fn.fnamemodify(path, ":t")
      if fname:match(exe_prefix) then
        local found = search_for_executable(path, exe_prefix)
        if found then
          return found
        end
      end
    else
      -- check if filename starts with our expected prefix
      local fname = vim.fn.fnamemodify(path, ":t")
      if fname:match(exe_prefix) and vim.fn.executable(path) == 1 then
        return path
      end
    end
  end

  return nil
end
local function find_godot_executable(version)
  -- extract major.minor.patch
  local major, minor, patch, beta = string.match(version, "(%d+)%.(%d+)%.(%d+)-beta%.(%d+)")
  local suffix
  local version_key

  if major and minor and patch and beta then
    -- it's a beta release
    version_key = major .. "_" .. minor
    suffix = "-beta" .. beta
  else
    -- stable release (no -beta in string)
    major, minor, patch = string.match(version, "(%d+)%.(%d+)%.(%d+)")
    if not (major and minor and patch) then
      print("Invalid version string: " .. version)
      return nil
    end
    version_key = major .. "[-_.]" .. minor
    suffix = "-stable"
  end

  local base_path = "~/.local/share/godot/app_userdata/Godots/versions/"
  local folder_pattern = "Godot_v" .. version_key .. suffix .. "_mono*"

  -- find matching folders
  local folders = vim.fn.globpath(base_path, folder_pattern, false, true)

  if #folders == 0 then
    print("No Godot folder found for version " .. version)
    return nil
  end

  local search_pattern = "Godot_v" .. version_key .. suffix.gsub(suffix, "%-", "%%-") .. "_mono.*"
  for _, folder in ipairs(folders) do
    local exe = search_for_executable(folder, search_pattern)
    if exe then
      print("Found Godot executable: " .. exe)
      return exe
    end
  end

  print("No executable found for " .. version)
  return nil
end
---Add the godot bin path for the current_dir
---@param callback? function
function SavePathForCurrentDirectory(callback)
  -- Get current working directory
  local current_dir = get_cwd()

  -- try auto detection
  local version = get_godot_version_from_csproj()
  local godot_exec
  if version then
    godot_exec = find_godot_executable(version)
  end
  if godot_exec then
    save_or_create(godot_exec, current_dir)
    return
  end
  -- Ask the user for a path input
  vim.ui.input({
    prompt = "Enter path for Godot: ",
    completion = "file", -- Enables file path completion
  }, function(input)
    -- Check if the user provided input or cancelled
    if input then
      local res = save_or_create(input, current_dir)
      if res then
        -- Save to file
        if not res then
          return
        end
        if callback ~= nil then
          callback(input)
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
vim.api.nvim_create_user_command("SaveDirPath", function()
  SavePathForCurrentDirectory()
end, {})
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
  local godot_command = vim.fn.shellescape(godot) .. " " .. vim.fn.shellescape(scene_name)
  local build_command = "dotnet build"
  local cmd = build_command .. " && " .. godot_command .. " && $SHELL"
  s_last_scene_run = scene_name

  Snacks.terminal({ "bash", "-c", cmd }, { cwd = Util.root(), auto_close = true })
end

return M
