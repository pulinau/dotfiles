-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
  -- 1. Export variables to the systemd user environment
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- 2. Force restart the desktop portal now that it can read the variables
  hl.exec_cmd("systemctl --user restart xdg-desktop-portal.service")

  hl.exec_cmd(PROGRAMS.wallpaper)
  hl.exec_cmd("swaync")
  hl.exec_cmd("hyprsunset")
end)
