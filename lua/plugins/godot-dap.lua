local godot = require("monouri.godot")
return {
  "fm39hz/nvim-dap-godot-mono",
  dependencies = {
    "stevearc/overseer.nvim",
  },
  ft = "cs",
  opts = {
    -- Godot-specific configuration grouped under `godot`.
    godot = {
      -- Path to the Godot executable.
      -- Defaults to the $GODOT environment variable, or "godot" if not set.
      godot_executable = godot.GetCurrentSavedPath() or os.getenv("GODOT") or "godot",

      -- Path to netcoredbg executable.
      -- Defaults to looking it up in your PATH (works with Mason).
      -- Set to nil to let the plugin auto-detect.
      netcoredbg_path = nil,

      -- Whether to print extra debug info
      verbose = false,

      -- Custom build command
      -- Defaults to { "dotnet", "build" }
      build_cmd = { "dotnet", "build" },

      -- How deep to scan from the solution directory for project.godot
      -- Defaults to 2. Set to 0 to only check the solution directory.
      scan_depth = 2,

      -- Scene exclusion patterns (Lua patterns)
      -- Scenes matching these patterns will be excluded from the scene picker
      -- Defaults to { "/addons/", "/%.godot/" }
      scene_exclude_patterns = { "/addons/", "/%.godot/" },
    },

    -- Backwards compatibility: old top-level keys are still accepted but
    -- nesting them under `godot` is preferred and will be required in a
    -- future release. If you still use top-level keys they will be migrated
    -- with a deprecation warning.
  },
}
