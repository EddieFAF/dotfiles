#    ░█▀█░█░░░▀█▀░█▀█░█▀▀░█▀▀░█▀▀░░░░▀▀█░█▀▀░█░█
#    ░█▀█░█░░░░█░░█▀█░▀▀█░█▀▀░▀▀█░░░░▄▀░░▀▀█░█▀█
#    ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

# ------------------------------------------------------------------------------
# File Purpose
#   This file acts as the primary registry for shell aliases (shortcuts).
#   It maps short commands to longer, complex sequences to improve productivity
#   and safety.
#
# Problems Solved
#   - Reduces keystrokes for common commands (e.g., `git status` -> `gst`).
#   - Adds safety nets to destructive commands (e.g., `rm` -> `rm -i`).
#   - Standardizes behavior across different operating systems (macOS vs Linux).
#   - Integrates modern tools (bat, eza, nvim) transparently.
#
# Features / Responsibilities
#   - System Privilege Aliases (sudo wrappers).
#   - Navigation Shortcuts (.., ..., ~).
#   - Modern Tool Replacements (ls -> eza).
#   - Extensive Git Shortcuts.
#   - Global Aliases (Pipe expansions).
#
# Usage Notes
#   To disable this entire file, set `LOAD_CUSTOM_ALIASES="No"` in $ZDOTDIR/user.conf.
#   $EDITOR is defined in '$ZSH_CONFIG_ROOT/conf.d/env.zsh'
# ------------------------------------------------------------------------------


# Initialization
# ───────────────────────────────────────────────────────────────────────
## Preparation steps: Feature flags, clean slate, and OS detection.

# Reset: Remove all existing aliases to prevent conflicts or stale definitions.
unalias -a

# Environment Detection
# Capture the kernel name to handle OS-specific flags (Darwin vs Linux).
local detected_os
detected_os=$(uname -s)


# System & Privileges
# ───────────────────────────────────────────────────────────────────────
## Wrappers for administrative commands and safety features.
# Admin Helpers
alias _="sudo"        # Quick sudo shorthand

# ------------------------------------------------------------------------------
# Auto-Sudo (Linux Only)
# On Linux, system commands almost always require root. This wrapper adds
# 'sudo' automatically to specific commands to save typing.
if [[ "$detected_os" == "Linux" ]]; then
    for sys_cmd in mount umount sv updatedb su shutdown poweroff reboot; do
        alias "$sys_cmd"="_ $sys_cmd"
    done
    unset sys_cmd
fi

# ------------------------------------------------------------------------------
# Map 'history' to the underlying 'fc' command with a custom format
# -l: list
# -t: time format (takes the string arguments)
alias history="fc -l -t '%Y/%m/%d %H:%M:%S:   '"

# ----------------------------------------------------------------------------
# Man Page Fuzzy Finder
# Uses fzf to search and preview man pages interactively.
# Requires 'fzf' to be installed.
(( $+commands[fzf] )) && alias man="fzf-man"

# ------------------------------------------------------------------------------
# Safety Nets
# Force interactive mode (-i) to prompt before destructive actions.
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias rm="rm -i"      # "Are you sure?" prompt for deletions

# ------------------------------------------------------------------------------
# "The Magic Fixer"
# Re-runs the last command in history ($(fc ...)) prepended with sudo.
alias please='_ $(fc -ln -1)'

# ------------------------------------------------------------------------------
# GNU/BSD Compatibility
# Linux specific flags that don't exist on macOS/BSD.
if [[ "$detected_os" == "Linux" ]]; then
    alias chown="chown --preserve-root"
    alias chmod="chmod --preserve-root"
    alias chgrp="chgrp --preserve-root"
fi


# Navigation & Directories
# ───────────────────────────────────────────────────────────────────────
## Shortcuts for moving around the file system.

# ------------------------------------------------------------------------------
# Quick Jumps
alias -- ~="cd ~"       # Go Home
alias -- -="cd -"       # Go to Previous Directory

# Numbered Shortcuts (Zsh Directory Stack)
# Create aliases .1 through .100 to jump back in the directory stack.
alias .1="cd -"
for n in {2..100}; do
    alias ".$n"="cd -$n"  # Example: .5 = cd -5, .10 = cd -10
done

# ------------------------------------------------------------------------------
# Dynamic Bookmarks
## Define shortcuts based on DIRECTORY_SHORTCUTS in user.conf
## [Abbr]="Path" -> "-Abbr"="cd Path"

# Dynamic Alias Creation
#    Loop through keys (abbr) and values (dir) and create aliases unconditionally.
for abbr dir in "${(@kv)DIRECTORY_SHORTCUTS}"; do
    if [[ -d "$dir" ]]; then
        alias -- "-$abbr"="cd $dir" # Example: -dv = cd ~/Developer

        # Register as a Named Directory (allows nvim ~pj and prompt shortening)
        hash -d "$abbr"="$dir"
    fi
done

# Editors & Configurations
# ───────────────────────────────────────────────────────────────────────
## Shortcuts for editing configuration files and selecting editors.
# Shell Configuration Editors
# Only define aliases if the configuration files exist.
[[ -f $ZDOTDIR/.zshrc ]]            && alias zedit='_safe_edit $ZDOTDIR/.zshrc'
[[ -f ~/.bashrc ]]                  && alias bedit='_safe_edit ~/.bashrc'
[[ -f ~/.config/fish/config.fish ]] && alias fedit='_safe_edit ~/.config/fish/config.fish'
[[ -f $XDG_NVIM/init.lua ]]         && alias nvedit='_safe_edit $XDG_NVIM/init.lua'

# SAFETY FIX:
# 1. We map 'visudo' to use sudo (since regular users can't read /etc/sudoers)
# 2. We trigger the check function to ensure the file is there first.
alias visudo='_safe_edit /etc/sudoers true'


# Utilities & Tools
# ───────────────────────────────────────────────────────────────────────
## Replacing legacy unix tools with modern Rust/Go alternatives.

# ------------------------------------------------------------------------------
# Modern Replacements

# 'cat' -> 'bat' (Syntax highlighting)
(( $+commands[bat] ))     && alias cat='bat'

# 'df' -> 'duf' (Disk Usage / Free utility)
(( $+commands[duf] ))     && alias df="duf" || alias df="df -h"

# 'rm' -> 'trash' (Moves to trash instead of permanent delete)
(( $+commands[trash] ))   && alias del="trash"

# 'grep' -> 'ripgrep' (Much faster search)
if (( $+commands[rg] )); then
    alias grep="rg"
    alias -g ':G'="| rg"
elif (( $+commands[ripgrep] )); then
    alias grep="ripgrep"
    alias -g ':G'="| ripgrep"
else
    alias -g ':G'="| grep"
fi

# 'find' -> 'fd' (Simple, fast, user-friendly)
(( $+commands[fd] )) && alias find="fd"

# 'diff' -> 'delta' (Syntax highlighted diffs)
(( $+commands[delta] )) && alias diff="delta"


# ------------------------------------------------------------------------------
# Clipboard (Cross-Platform)
# Abstracts 'copy' and 'paste' regardless of OS.

if [[ "$detected_os" == "Darwin" ]]; then
    alias copy='pbcopy'
    alias paste='pbpaste'
else
    # Linux: Try xsel first, fallback to xclip
    if (( $+commands[xsel] )); then
        alias copy='xsel --clipboard --input'
        alias paste='xsel --clipboard --output'
    elif (( $+commands[xclip] )); then
        alias copy='xclip -selection clipboard'
        alias paste='xclip -selection clipboard -o'
    fi
fi

# ------------------------------------------------------------------------------
# Network & Process

alias ping='ping -c 5'                 # Stop after 5 pings
alias fastping='ping -c 100 -s .2'     # Stress test
alias gping="ping -c 5 google.com"     # Connectivity check

# Process Listing (ps)
alias paux='ps aux | grep'

# Memory/CPU Sorting (Handles flag differences between macOS/Linux)
if [[ "$detected_os" == "Linux" ]]; then
    alias psmem='ps auxf | sort -nr -k 4'
    alias pscpu='ps auxf | sort -nr -k 3'
else
    alias psmem='ps aux | sort -nr -k 4'  # macOS lacks 'f' forest view in aux
    alias pscpu='ps aux | sort -nr -k 3'
fi

alias killl='killall -q'


# Global Output Modifiers
# ───────────────────────────────────────────────────────────────────────
## Global aliases (-g) are expanded anywhere in the command line,
## not just at the beginning. They act like pipes.

# Usage:  cat file.txt :G pattern
# (Defined above in the grep/ripgrep section)

# Usage:  long_command :L
alias -g ':L'="| less"

# Usage:  ls -la :H
alias -g ':H'="| head"
alias -g ':T'="| tail"
alias -g ':S'="| sed"

# Redirection Shortcuts
alias -g ':NE'="2> /dev/null"        # Silence Errors
alias -g ':NUL'="> /dev/null 2>&1"   # Silence Everything (Output + Errors)
alias -g ':LL'="2>&1 | less"         # Pipe Output+Errors to Less


# Miscellaneous
# ───────────────────────────────────────────────────────────────────────

alias cls="clear"                   # Clear screen
alias clean="clear"                 # Clear screen too
alias h="history"                   # History
alias weather='curl -s wttr.in'     # Check weather
alias myip="curl ipinfo.io/ip"      # Check Public IP
alias md="mkdir -p"                 # Create parent directories automatically
alias new="touch"                   # Create new file

# Tmux Smart Exit
#   - If inside Tmux: Kill the specific session.
#   - If in normal shell: Exit.
alias ':q'='[ -n "$TMUX" ] && tmux kill-session -t $(tmux display-message -p "#S") || exit'

# Time & Date
# Copies formatted date to clipboard and prints it.
alias dday='date +"%Y.%m.%d - " | copy ; date +"%Y.%m.%d"'
alias week='date +%V'

# Cleanup
unset detected_os
unset _pac
unset _sys_open

