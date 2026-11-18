# =========================================================
# fzf
# =========================================================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'  # strip-cwd-prefix removes the leading ./ from results

# Ctrl-T uses fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# UI
export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt="  "
  --pointer="  "
  --preview-window=right:65%:wrap:border-left
'

# Ctrl+R options: reverse history search with inline info
export FZF_CTRL_R_OPTS="\
--height ${FZF_TMUX_HEIGHT:-50%} \
--reverse \
--scheme=history \
--exact \
--ansi \
--inline-info"

export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# Ctrl+F: file picker excluding hidden files
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"  # LBUFFER is the text left of the cursor
  zle reset-prompt
}
zle -N _fzf_file_no_hidden


# FZF SSH quick connect
fzf_ssh() {
	emulate -L zsh
	local host
	[[ -r ~/.ssh/config ]] || return
	host=$(awk '/^Host / && $2 != "*" {print $2}' ~/.ssh/config | fzf --preview 'dig {} +short; ping -c1 {} 2>/dev/null | head -1')
	[[ -n $host ]] && ssh "$host"
}

# FZF process killer
fkill() {
	emulate -L zsh
	local pid
	if [[ $UID -ne 0 ]]; then
		pid=$(ps -u "$UID" -o pid,comm --no-headers | fzf -m | awk '{print $1}')
	else
		pid=$(ps -ef | awk 'NR>1 {print $2, $8}' | fzf -m | awk '{print $1}')
	fi

	[[ -n $pid ]] && kill -"${1:-9}" ${(f)pid}
}
