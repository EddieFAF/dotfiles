
# Set the directory we want to store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit wait lucid light-mode depth"1" for \
    zsh-users/zsh-history-substring-search \
    agkozak/zsh-z

# SSH Plugin
zinit light sunlei/zsh-ssh

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::debian
zinit snippet OMZP::tmux
zinit snippet OMZP::command-not-found

zinit light junegunn/fzf

autoload -Uz compinit


# Location of the completion dump file
COMPDUMP="${ZDOTDIR}/cache/zcompdump"

# Initialize the completions system and check for cache once a day
if [[ -n "${COMPDUMP}"(#qN.mh+24) ]]; then
    # If .zcompdump is older than 24 hours, check for changes (-i)
    compinit -i -d "${COMPDUMP}"
    touch "${COMPDUMP}"
else
    # Otherwisem juste read the file (-d) without checking (-C)
    compinit -C -d "${COMPDUMP}"
fi

zinit cdreplay -q

[[ -f "$ZDOTDIR/conf.d/functions.zsh" ]] && source "$ZDOTDIR/conf.d/functions.zsh"
[[ -f "$ZDOTDIR/conf.d/hooks.zsh" ]] && source "$ZDOTDIR/conf.d/hooks.zsh"
#[[ -f "$ZDOTDIR/conf.d/keybinds.zsh" ]] && source "$ZDOTDIR/conf.d/keybinds.zsh"

# HISTORY SUBSTRING SEARCHING
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

zinit lucid wait for zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
zle -N history-substring-search-up
zle -N history-substring-search-down

# Navigation Options
# ───────────────────────────────────────────────────────────────────────
setopt AUTO_CD              # Typing 'dir' becomes 'cd dir'
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # Tab completing a directory appends a slash
setopt LIST_PACKED          # Minimize space in completion lists
setopt AUTO_PUSHD           # Push every visited directory to the stack
setopt PUSHD_IGNORE_DUPS    # Do not record the same directory twice
setopt PUSHD_SILENT         # Do not print the stack every time you cd

# Completion Behavior
# ───────────────────────────────────────────────────────────────────────
setopt COMPLETE_IN_WORD     # Allow completion from within a word/cursor position
setopt GLOB_COMPLETE        # Show autocompletion menu for globs
setopt HASH_LIST_ALL        # Hash entire path for faster completion
setopt EXTENDED_GLOB        # Use '#', '~', and '^' for advanced matching
setopt GLOB_DOTS            # Allow globbing to match hidden files (dotfiles)
setopt ALWAYS_TO_END        # Move cursor to end of word after completion

# Disable standard menu completion behavior in favor of fzf-tab
unsetopt MENU_COMPLETE

# Corrections & Safety
unsetopt FLOWCONTROL        # Disable Ctrl+S/Ctrl+Q output freezing
unsetopt NOMATCH            # Don't error if a glob has no matches (pass to command)
unsetopt CORRECT            # Disable "Did you mean..?" spelling correction


# History Configuration
# ───────────────────────────────────────────────────────────────────────
setopt SHARE_HISTORY             # Share history between open terminals immediately
setopt INC_APPEND_HISTORY_TIME   # Append to history file as soon as command finishes
setopt EXTENDED_HISTORY          # Save timestamp and duration of commands
setopt HIST_IGNORE_ALL_DUPS      # Don't save duplicates
setopt HIST_IGNORE_SPACE         # Don't save commands starting with a space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks
setopt HIST_VERIFY               # Show command with substitutions before executing

# Paths & Limits
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-cache/zhistory"
export HISTSIZE=50000
export SAVEHIST=50000
export HIST_STAMPS="dd.mm.yyyy"
export HISTORY_IGNORE="(zsh|clear|ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export HISTDUP=erase


# Job Control & Feedback
# ───────────────────────────────────────────────────────────────────────
setopt NOTIFY                  # Report status of background jobs immediately
setopt NOHUP                   # Don't kill background jobs on exit
setopt MAILWARN                # Print mail warning message
setopt INTERACTIVE_COMMENTS    # Allow comments (#) in interactive shell
setopt NOBEEP                  # No beep on error

set termguicolors

# Autosuggestions Config
# ───────────────────────────────────────────────────────────────────────
# Async Mode: Prevents lagging while typing large commands
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Strategy: Try history first, then completion engine
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Styling: Grey text (240 is standard dark grey)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

# Increase the minimum length before a suggestion is fetched
ZSH_AUTOSUGGEST_MIN_BUFFER_SIZE=4

# Disable suggestions for long buffers (prevents lag on large pastes)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Ignore internal/unrelated widgets to drastically speed up startup binding
ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
    orig-\*
    beep
    run-help
    set-local-history
    which-command
    yank
    yank-pop
)

# Load menu-style completion.
zmodload -i zsh/complist
bindkey -M menuselect '^M' accept

# Completions
# Menu-style completion
zstyle ':completion:*' menu select

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no


# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
#zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' default-color ""
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --long --header --icons --group-directories-first --group --git --all --links --color=always $realpath'

# Replace zsh's default completion selection menu with fzf!
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags '--height=50%' '--layout=reverse' '--info=inline'
# 프리뷰 창 설정
zstyle ':fzf-tab:*' preview-window 'right:50%:wrap'
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '(bat --color=always --style=numbers,changes $realpath 2>/dev/null || \
  ls -1 -la --color=always $realpath 2>/dev/null || \
  echo "No preview available") 2>/dev/null | head -200'

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap


#####################
# FZF SETTINGS      #
#####################
export FZF_BASE=$(which fzf)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --select-1 --exit-0
"
#export FZF_ALT_C_OPTS='--preview="ls {}" --preview-window=right:60%:wrap'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window=up:3:hidden:wrap
  --bind '?:toggle-preview'
  --height='50%'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_TMUX_HEIGHT="80%"
export FZF_CATPPUCCIN_MACCHIATO=" \
  --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
  --multi"

export FZF_THEME=$FZF_CATPPUCCIN_MACCHIATO

export FZF_DEFAULT_OPTS=" \
 --prompt='~ ❯ ' \
 --height='80%' \
 --marker='✗' \
 --pointer='▶' \
 --border=none \
 --inline-info \
 --layout=reverse \
 --preview                                                                 \
     '([[ -f {} ]] &&                                                      \
     (bat --style=numbers --color=always {} || ([[ -d {} ]] && \
     (eza --tree --icons --color=always {} | less)) || echo {} 2> /dev/null | head -200'
  --color 'border:#aaaaaa,label:#cccccc' \
  --color 'preview-border:#9999cc,preview-label:#ccccff' \
  $FZF_THEME"

#export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_COMPLETION_TRIGGER="**"


# ----------------------------------------------------------------------------
# Aliases
source $ZDOTDIR/aliases

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(starship init zsh)"

# vim: ft=zsh
