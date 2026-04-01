function settheme --description "Change system-wide terminal and editor theme"
    set -l theme_name $argv[1]
    set -l theme_variant $argv[2]

    if test (count $argv) -ne 2
        echo "Usage: settheme [catppuccin|tokyonight] [variant]"
        return 1
    end

    # Determine config path
    set -l config_home $XDG_CONFIG_HOME
    if test -z "$config_home"
        set config_home "$HOME/.config"
    end

    # Write to the shared profile
    echo "THEME_NAME=\"$theme_name\"" >"$config_home/theme_profile"
    echo "THEME_VARIANT=\"$theme_variant\"" >>"$config_home/theme_profile"

    echo "Theme updated to $theme_name ($theme_variant). Reload your terminal now."
end
