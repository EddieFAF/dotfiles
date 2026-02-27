# ------------------------------------------------------------------------------
# Sudo Prompt
# Custom prompt when asking for root password (displays username).
export SUDO_PROMPT="${COLOR[RED]}[NOTE]${COLOR[RESET]} Deploying root access for ${COLOR[YELLOW]}${COLOR[BOLD]}%u${COLOR[RESET]}, Password please: "


# Core Directory & Path Setup
# ───────────────────────────────────────────────────────────────────────
## Defines the physical locations of configuration files and project directories.
## We use standard XDG locations where possible for cleanliness.

# Primary workspace for code projects
export PROJECTS_ROOT="$HOME/coding"

# Directory Shortcuts & Project Paths
# Used by:
#  1. 'pj' command (to find projects)
#  2. aliases.zsh (to create navigation shortcuts like -pj, -wk)
typeset -gA DIRECTORY_SHORTCUTS
DIRECTORY_SHORTCUTS=(
    [dt]="${DOTFILES_ROOT}"
    [pj]="$HOME/Projects"
    [wk]="$HOME/Work"
    [ws]="$HOME/workspace"
    [cd]="$HOME/coding"
    [dv]="$HOME/Developer"
    [dc]="$HOME/Documents"
    [dl]="$HOME/Downloads"
    [cf]="$HOME/.config"
)

# SSH & Remote Settings
# ───────────────────────────────────────────────────────────────────────
## Configuration applied only when connected via SSH.

if [[ -n "$SSH_CONNECTION" ]]; then
    # Revert to standard Vim on remote servers (safer than assuming Nvim config exists)
    export EDITOR='nvim'

    # Display System Info
    # If neofetch exists, run it. If lolcat exists, colorize it.
    if (( $+commands[neofetch] )); then
        if (( $+commands[lolcat] )); then
            # -S 10: Spread rainbow
            # -F 0.05: Frequency
            neofetch | lolcat -S 10 -F 0.05
        else
            neofetch
        fi
    fi
fi
