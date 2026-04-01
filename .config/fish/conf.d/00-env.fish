#
# Set global environment variables
#

# ensure that the XDG variables are set
if test -z "$XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

#set -gx VISUAL codium
set -gx EDITOR nvim

if type -q starship
    starship init fish | source
    set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
    set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
end

if type -q claude
    set -gx CLAUDE_CONFIG_DIR $XDG_CONFIG_HOME/claude
end

