if status is-interactive
    # Commands to run in interactive sessions can go here
    mise activate fish | source
end

# Add mise shims to the front of the PATH
fish_add_path --move --prepend "$HOME/.local/share/mise/shims"

# Disable the fish greeting message
set fish_greeting ""

# make sure the --git-dir is the same as the
# directory where you created the repo above.
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# ================
# ABBREVIATIONS
# ================
abbr mkdir 'mkdir -p'

# Git commands.
abbr -a -- ga 'git add'
abbr -a -- gb 'git branch'
abbr -a -- gba 'git branch -a'
abbr -a -- gbd 'git branch -d'
abbr -a -- gbD 'git branch -D'
abbr -a -- gbl 'git blame'
abbr -a -- gca 'git commit --amend'
abbr -a --set-cursor='%' -- gcm 'git commit -m "%"'
abbr -a -- gco 'git checkout'
abbr -a -- gcob 'git checkout -b'
abbr -a -- gcp 'git cherry-pick'
abbr -a -- gd 'git diff'
abbr -a -- gds 'git diff --staged'
abbr -a -- gm 'git merge'
abbr -a -- gp 'git push'
abbr -a -- gpl 'git pull'
abbr -a -- grh 'git reset HEAD'
abbr -a -- grs 'git restore --staged'
abbr -a -- gs 'git status'
abbr -a -- gsh 'git show'
abbr -a -- gst 'git stash'
abbr -a -- gstl 'git stash list'
abbr -a --set-cursor='%' -- gstp 'git stash push -m "%"'
abbr -a -- gstpop 'git stash pop'
