#    ░█▀▀░█░█░█▀█░█▀▀░▀█▀░█▀▀░█▀█░█▀▀
#    ░█▀▀░█░█░█░█░█░░░░█░░█░█░█░█░▀▀█
#    ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀

# ------------------------------------------------------------------------------
# File Purpose
#   This file defines custom shell functions and utilities.
#   It acts as a standard library for interactive shell usage.
#
# Problems Solved
#   - Wrapper for Neovim to handle Sudo and Config switching automatically.
#   - Wrapper for Lazygit to allow changing directories on exit.
#   - Debugging tools for Zsh startup profiling.
#   - Safety guard for Kubernetes production contexts.
#
# Features / Responsibilities
#   - `v`: Smart Editor wrapper.
#   - `lg`: Smart Git wrapper.
#   - `alias`: Pretty printing for aliases.
#   - `kubectl`: Production guardrail.
#
# Usage Notes
#   - Set LOAD_CUSTOM_FUNCTIONS="No" in ~/user.conf to disable.
# ------------------------------------------------------------------------------



# ........................[  4. Developer Tools  ]........................ #

# ------------------------------------------------------------------------------
# Function: y
# Description:
#   Wraps 'yazi' to enable directory changing upon exit.
# ------------------------------------------------------------------------------
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
          [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
            rm -f -- "$tmp"
          }

### ARCHIVE EXTRACTION
# usage: x <file>
function x {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: x <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "x: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# ------------------------------------------------------------------------------
# Function: lg
# Description:
#   Wraps 'lazygit' to enable directory changing upon exit.
#   Emulates the behavior of yazi/ranger file managers.
# ------------------------------------------------------------------------------
function lg() {
    if ! (( $+commands[lazygit] )); then
        print "${COLOR[RED]}Error:${COLOR[RESET]} 'lazygit' is not installed." >&2
        return 1
    fi

    local lg_config_file="${TMPDIR:-/tmp}/lazygit-chdir"
    LAZYGIT_NEW_DIR_FILE="$lg_config_file" command lazygit "$@"

    if [[ -f "$lg_config_file" ]]; then
        local target_dir=$(cat "$lg_config_file")
        if [[ -d "$target_dir" && "$target_dir" != "$PWD" ]]; then
            cd "$target_dir"
            print "${COLOR[GREEN]}:: Switched to:${COLOR[RESET]} $target_dir"
        fi
        rm -f "$lg_config_file"
    fi
}


# ------------------------------------------------------------------------------
# Function: pj (Project Jumper)
# Description:
#   Fuzzy find directories in Code/Work/Projects and jump to them.
#   Integrates with zoxide if available.
# ------------------------------------------------------------------------------
pj() {
    emulate -L zsh # Reset zsh options for this function (prevents bugs)

    # 1. Dependency Check
    if ! (( $+commands[fzf] )); then
        print "${COLOR[RED]}Error: fzf is required.$COLOR[RESET]"
        return 1
    fi

    # 2. Configuration  # TODO: Move this to a user-editable config file or environment variable
    # Define your search roots here
    # Search paths defined in user.conf, fallback to defaults if missing
    local -a raw_paths
    if (( ${#DIRECTORY_SHORTCUTS} > 0 )); then
        raw_paths=("${(@v)DIRECTORY_SHORTCUTS}")
    else
        raw_paths=(
            "$HOME/Code"
            "$HOME/Projects"
            "$HOME/Work"
            "$HOME/workspace"
            "${DOTFILES_ROOT}"
        )
    fi

    # 3. Fast Validation (Zsh Magic)
    # (N/) filters the list to only existing directories.
    # $^ expands the array to apply the check to each element.
    local search_paths=($^raw_paths(N/))

    if (( ${#search_paths} == 0 )); then
        print "${COLOR[YELLOW]}No valid project directories found.$COLOR[RESET]"
        return 1
    fi

    # 4. Preview Strategy (Smart Fallback)
    local preview_cmd="ls -A --color=always {}"
    (( $+commands[eza] )) && preview_cmd="eza -1 --color=always --icons --group-directories-first --git {}"

    # 5. Search Execution
    local proj
    local fzf_opts=(
        --query "$*"       # Use function args as search query
        --select-1         # Auto-select if only 1 match found
        --exit-0           # Exit if query yields no results
        --prompt="🚀 Jump > "
        --preview "$preview_cmd"
        --height=50%
        --layout=reverse
        --border
    )

    # Use 'fd' if available (faster, respects .gitignore), else 'find'
    if (( $+commands[fd] )); then
        # --absolute-path ensures cd works from anywhere
        proj=$(fd . "${search_paths[@]}" --min-depth 1 --max-depth 2 --type d --absolute-path 2>/dev/null | fzf "${fzf_opts[@]}")
    else
        proj=$(find "${search_paths[@]}" -mindepth 1 -maxdepth 2 -type d 2>/dev/null | fzf "${fzf_opts[@]}")
    fi

    # 6. Result Handling
    if [[ -n "$proj" ]]; then
        # Zoxide / Autojump integration
        (( $+commands[zoxide] )) && zoxide add "$proj"

        cd "$proj"

        # Optional: Print where we landed
        print "${COLOR[GREEN]}➜ Switched to: ${COLOR[BOLD]}$proj${COLOR[RESET]}"
    fi
}


# ........................[  5. Utilities  ]........................ #

function sysinfo()   # Get current host related info.
{
    echo -e "\n${BRed}System Informations:$NC " ; uname -a
    echo -e "\n${BRed}Online User:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Date :$NC " ; date
    echo -e "\n${BRed}Server stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Public IP Address :$NC " ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo -e "\n${BRed}CPU info :$NC "; cat /proc/cpuinfo ;
    echo -e "\n"
}

### set common functions
#############

# Find a file with a pattern in name:
function ff()
{
    find . -type f -iname '*'"$*"'*' -ls ;
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function nvims() {
  items=("default" "nvim-2026" "nvim-mini" "nvim-minimax" "nvim-dep2025" "nvim-dep" "mvim" "nvim-mvim" "nvim-onlyati")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0 --preview-window=hidden)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# ------------------------------------------------------------------------------
# Function: weather
# Description: Fetches weather report using wttr.in.
# ------------------------------------------------------------------------------
function weather() {
    # 1. Dependency Check
    if ! (( $+commands[curl] )); then
        print "${COLOR[RED]}Error: curl is required.$COLOR[RESET]"
        return 1
    fi

    # 2. Configuration
    local default_location="${WEATHER_DEFAULT_LOC:-Gwalior}"
    local location="${1:-$default_location}"

    # Handle spaces (New York -> New+York)
    location="${location// /+}"

    # 3. Smart Layout Logic
    # We build the URL parameters dynamically.
    # m = metric, Q = quiet (no message header)
    local -a args=("m" "Q")

    # Use native Zsh $COLUMNS variable (faster/safer than tput)
    local width="${COLUMNS:-$(tput cols)}"

    if [[ "$width" -lt 80 ]]; then
        # Tiny screen? Show ONLY current weather (no forecast tables)
        args+=("0")
    elif [[ "$width" -lt 140 ]]; then
        # Medium screen? Force narrow version (vertical stack)
        args+=("n")
    fi
    # > 140 cols will use the standard wide view

    # 4. Construct URL
    # Join args with '&' to ensure wttr.in parses them correctly
    # (zsh array joining magic: ${(j:&:)args})
    local url_params="${(j:&:)args}"

    curl -s "wttr.in/${location}?${url_params}"
}



# ........................[  7. Lazy Loading Wrappers  ]........................ #

# ------------------------------------------------------------------------------
# Function: nvm (Lazy Load)
# Description:
#   Loads NVM (Node Version Manager) only when a node-related command is run.
#   Usage: nvm, node, npm, npx, pnpm, yarn
# ------------------------------------------------------------------------------
# 1. Define the commands that trigger loading
local nvm_triggers=(nvm node npm npx pnpm yarn)

# 2. Check if NVM exists before setting up triggers
if [[ -d "$HOME/.nvm" ]]; then

    # The "Worker" function
    _nvm_lazy_load() {
        # Cleanup: Unset the dummy functions
        unset -f _nvm_lazy_load $nvm_triggers

        # Setup: Load NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        # Optional: Load bash completion (makes nvm usable immediately)
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # Execution: Run the command that triggered this function
        # "$0" is the command name (e.g., 'npm'), "$@" are the args
        exec "$0" "$@"
    }

    # 3. Create the dummy triggers
    for cmd in $nvm_triggers; do
        eval "function $cmd() { _nvm_lazy_load \"\$@\"; }"
    done
fi

# ------------------------------------------------------------------------------
# Function: pyenv (Lazy Load)
# Description:
#   Loads Pyenv only when a python-related command is run.
#   Usage: pyenv, python, pip, poetry
# ------------------------------------------------------------------------------
# Check if pyenv is in path OR installed in home
# 1. Define the trigger command list
# Add any other pyenv-managed commands here (e.g., pytest, jupyter)
local _pyenv_triggers=(pyenv python pip poetry)

# 2. The single "Worker" function
_pyenv_lazy_load() {
    # Cleanup: Remove the dummy functions/aliases so they don't loop
    unset -f _pyenv_lazy_load
    for cmd in $_pyenv_triggers; do unset -f $cmd; done

    # Setup: Add pyenv to PATH if it's not there (Standard Install)
    [[ -d "$HOME/.pyenv/bin" ]] && export PATH="$HOME/.pyenv/bin:$PATH"

    # Activate: Initialize pyenv (this updates PATH and shims)
    if (( $+commands[pyenv] )); then
        eval "$(pyenv init -)"

        # Optional: Load pyenv-virtualenv if you use it
        # eval "$(pyenv virtualenv-init -)"
    else
        echo "Error: pyenv not found." >&2
        return 1
    fi

    # Re-run: Execute the command the user actually typed
    # "$0" is the function name (e.g., python), "$@" are the args
    exec "$0" "$@"
}

# 3. Create the triggers
# We check if pyenv exists roughly (directory or binary) before setting traps
if [[ -d "$HOME/.pyenv" ]] || (( $+commands[pyenv] )); then
    for cmd in $_pyenv_triggers; do
        # Define a function for each trigger that calls the loader
        eval "function $cmd() { _pyenv_lazy_load \"\$@\"; }"
    done
fi


