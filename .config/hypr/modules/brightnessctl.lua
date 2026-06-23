-- modules/brightness.lua
local M = {}

--------------------------------------------------------
-- SERVICE STATE DATA (BetterDisplay Engine)
--------------------------------------------------------
local hw_brightness = 50
local sw_gamma = 100

-- USER CONFIGURATION
local TARGET_MONITOR = "DP-3" -- Check via: hyprctl monitors
local I2C_BUS = "7"           -- Check via: ddcutil detect

--------------------------------------------------------
-- DIRECT EXECUTION ROUTINE
--------------------------------------------------------
local function show_notification(title, percentage)
    local cmd = string.format(
    "notify-send -e -u low -h string:x-canonical-private-synchronous:brightness_notif -h int:value:%d -i display-brightness-symbolic %q %q",
        percentage, title, string.format("%d%%", percentage))
    hl.exec_cmd(cmd)
end

function M.adjust(direction)
    -- Fetch active workspace properties safely
    local active_workspace = hl.get_active_workspace()
    if not active_workspace then return end

    local active_monitor = active_workspace.monitor and active_workspace.monitor.name

    -- ROUTE A: Laptop Screen Fallback (Using native backlight control tools)
    if active_monitor ~= TARGET_MONITOR then
        local action = direction == "up" and "5%+" or "5%-"
        local cmd = string.format(
        "brightnessctl set %s -m | awk -F ',' '{print $4+0}' | xargs -I{} notify-send -e -u low -h string:x-canonical-private-synchronous:brightness_notif -h int:value:{} -i display-brightness-symbolic %q \"{}%%\"",
            action, "Laptop Brightness")
        hl.exec_cmd(cmd)
        return
    end

    -- ROUTE B: External Display Protocol with Realtime Software Transitions
    if direction == "down" then
        if hw_brightness > 0 then
            hw_brightness = math.max(0, hw_brightness - 5)
            local cmd = string.format("ddcutil --bus %s --noverify --skip-ddc-checks setvcp 10 %d", I2C_BUS,
                hw_brightness)
            hl.exec_cmd(cmd)
            show_notification("Monitor Brightness", hw_brightness)
        else
            sw_gamma = math.max(10, sw_gamma - 10)
            local cmd = string.format("hyprctl hyprsunset gamma %d", sw_gamma)
            hl.exec_cmd(cmd)
            show_notification("Software Dimming", sw_gamma)
        end
    elseif direction == "up" then
        if sw_gamma < 100 then
            sw_gamma = math.min(100, sw_gamma + 10)
            if sw_gamma == 100 then
                hl.exec_cmd("hyprctl hyprsunset identity")
            else
                local cmd = string.format("hyprctl hyprsunset gamma %d", sw_gamma)
                hl.exec_cmd(cmd)
            end
            show_notification("Software Dimming", sw_gamma)
        else
            hw_brightness = math.min(100, hw_brightness + 5)
            local cmd = string.format("ddcutil --bus %s --noverify --skip-ddc-checks setvcp 10 %d", I2C_BUS,
                hw_brightness)
            hl.exec_cmd(cmd)
            show_notification("Monitor Brightness", hw_brightness)
        end
    end
end

return M
