local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ==========================================
-- VISUAL SETTINGS
-- ==========================================

local function get_shared_theme()
  local xdg_config = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
  local file = io.open(xdg_config .. "/theme_profile", "r")
  if not file then return "catppuccin", "mocha" end

  local contents = file:read("*a")
  file:close()
  local name = contents:match('THEME_NAME="([^"]+)"')
  local variant = contents:match('THEME_VARIANT="([^"]+)"')
  return name, variant
end

-- Apply theme based on config
local theme_name, theme_variant = get_shared_theme()
if theme_name == "tokyonight" then
  config.color_scheme = "Tokyo Night " .. theme_variant:gsub("^%l", string.upper)
elseif theme_name == "catppuccin" then
  config.color_scheme = "Catppuccin " .. theme_variant:gsub("^%l", string.upper)
end

config.font = wezterm.font("IosevkaInput")
config.font_size = 14
config.line_height = 1.2

config.window_background_opacity = 0.87
config.macos_window_background_blur = 10

-- Active/inactive pane highlights
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}
config.colors = {
  -- This is the color of the line between split panes
  split = "#fab387",
}

-- Other window settings
config.enable_tab_bar = true
config.window_decorations = "RESIZE"
config.initial_rows = 48
config.initial_cols = 150

-- Keybinds
require("keys").setup(config)

return config
