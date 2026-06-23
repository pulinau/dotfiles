--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

-- Application specific rules
hl.window_rule({ opacity = "0.90 0.90 1", match = { class = "^(zen)$" } })
hl.window_rule({ opacity = "0.80 0.80 1", match = { class = "^(kitty)$" } })
hl.window_rule({ opacity = "0.70 0.70 1", match = { class = "^(steamwebhelper)$" } })

hl.window_rule({ workspace = "6", match = { class = "^(steam)$" } })
hl.window_rule({ float = true, match = { title = "^(Friends List)$" } })
hl.window_rule({ float = true, match = { title = "^(Steam Settings)$" } })
