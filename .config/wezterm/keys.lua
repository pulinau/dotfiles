local wezterm = require("wezterm")
local act     = wezterm.action

local M       = {}

-- Define our layers
M.mod_pane    = "SUPER"
M.mod_tab     = "SUPER|SHIFT"
M.mod_resize  = "SUPER|ALT"

M.smart_split = wezterm.action_callback(function(window, pane)
  local dim = pane:get_dimensions()
  if dim.pixel_height > dim.pixel_width then
    window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
  else
    window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
  end
end)

function M.setup(config)
  config.keys = {
    -- ==========================================
    -- PANE MANAGEMENT (SUPER + hjkl)
    -- ==========================================
    { mods = M.mod_pane,   key = "h",     action = act.ActivatePaneDirection("Left") },
    { mods = M.mod_pane,   key = "l",     action = act.ActivatePaneDirection("Right") },
    { mods = M.mod_pane,   key = "k",     action = act.ActivatePaneDirection("Up") },
    { mods = M.mod_pane,   key = "j",     action = act.ActivatePaneDirection("Down") },
    { mods = M.mod_pane,   key = "w",     action = act.CloseCurrentPane({ confirm = true }) },
    { mods = M.mod_pane,   key = "Enter", action = M.smart_split },

    -- ==========================================
    -- TAB MANAGEMENT (SUPER + SHIFT + hjkl)
    -- ==========================================
    -- Navigate Tabs (h/l)
    { mods = M.mod_tab,    key = "h",     action = act.ActivateTabRelative(-1) },
    { mods = M.mod_tab,    key = "l",     action = act.ActivateTabRelative(1) },
    -- Move Tabs (j/k)
    { mods = M.mod_tab,    key = "j",     action = act.MoveTabRelative(-1) },
    { mods = M.mod_tab,    key = "k",     action = act.MoveTabRelative(1) },
    -- New/Close Tab
    { mods = M.mod_tab,    key = "t",     action = act.SpawnTab("CurrentPaneDomain") },
    { mods = M.mod_tab,    key = "w",     action = act.CloseCurrentTab({ confirm = true }) },

    -- ==========================================
    -- RESIZING (SUPER + ALT + hjkl)
    -- ==========================================
    { mods = M.mod_resize, key = "h",     action = act.AdjustPaneSize({ "Left", 2 }) },
    { mods = M.mod_resize, key = "l",     action = act.AdjustPaneSize({ "Right", 2 }) },
    { mods = M.mod_resize, key = "k",     action = act.AdjustPaneSize({ "Up", 2 }) },
    { mods = M.mod_resize, key = "j",     action = act.AdjustPaneSize({ "Down", 2 }) },

    -- ==========================================
    -- UTILITIES
    -- ==========================================
    -- Show Launcher (Find tabs/commands)
    { mods = M.mod_pane,   key = "p",     action = act.ShowLauncher },
    -- Pane Selection (Labels)
    { mods = M.mod_pane,   key = "s",     action = act.PaneSelect({ mode = "SwapWithActive" }) },
    -- Toggle Zoom
    { mods = M.mod_pane,   key = "z",     action = act.TogglePaneZoomState },
  }
end

return M
