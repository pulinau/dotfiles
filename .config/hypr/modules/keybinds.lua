--------------------------------------------------------------------------------
----                               KEYBINDINGS                              ----
--------------------------------------------------------------------------------

local mainMod = "SUPER"

-- Modules
local brightness = require("modules.brightnessctl")


-- =============================================================================
-- APPLICATIONS & LAUNCHERS
-- =============================================================================

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(PROGRAMS.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(PROGRAMS.browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(PROGRAMS.fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(PROGRAMS.menu))


-- =============================================================================
-- SYSTEM & SESSION CONTROL
-- =============================================================================

-- Close active window
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
closeWindowBind:set_enabled(true)

-- Reload quickshell
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/quickshell/reload.sh"))

-- Session exit / shutdown
hl.bind(mainMod .. " + DELETE",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- =============================================================================
-- WINDOW MANAGEMENT & NAVIGATION
-- =============================================================================

-- Move Focus (Arrows & Vim)
for key, dir in pairs({ left = "left", right = "right", up = "up", down = "down", h = "left", l = "right", k = "up", j = "down" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- Swap Windows (mainMod + ALT + Arrows/Vim)
for key, dir in pairs({ left = "l", right = "r", up = "u", down = "d", h = "l", l = "r", k = "u", j = "d" }) do
  hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Window States & Layouts
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Resizing Windows (Arrows & Vim)
local rs = hl.dsp.window.resize
hl.bind(mainMod .. " + SHIFT + left", rs({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + h", rs({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", rs({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", rs({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", rs({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", rs({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", rs({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", rs({ x = 0, y = -10, relative = true }), { repeating = true })

-- Mouse Dragging (Move / Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- To switch between windows in a floating workspace:
hl.bind(mainMod .. " + TAB", function()
  hl.dispatch(hl.dsp.window.cycle_next())   -- Change focus to another window
  hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)

-- =============================================================================
-- WORKSPACE MANAGEMENT
-- =============================================================================

-- Switch to workspace [0-9] & Move active window to workspace [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces (Mouse wheel)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))


-- =============================================================================
-- MULTIMEDIA & HARDWARE KEYS
-- =============================================================================

-- Audio Volume & Mute (Wireplumber)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })

-- Display Brightness
hl.bind("XF86MonBrightnessUp", function() brightness.adjust("up") end, { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", function() brightness.adjust("down") end, { repeating = true, locked = true })

-- Media Player Control (Playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
