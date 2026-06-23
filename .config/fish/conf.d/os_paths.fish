# ~/.config/fish/conf.d/os_paths.fish

# Inject platform-specific function folders before standard paths
switch (uname)
    case Linux
        set -g fish_function_path $XDG_CONFIG_HOME/fish/functions/linux $fish_function_path
    case Darwin
        set -g fish_function_path $XDG_CONFIG_HOME/fish/functions/macos $fish_function_path
end
