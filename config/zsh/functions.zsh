
C_RED=${fg[red]}
C_GREEN=${fg[green]}
C_YELLOW=${fg[yellow]}
C_CYAN=${fg[cyan]}
C_NC=${reset_color}

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

# Extract one or more archive files based on their extension (thanks to: https://github.com/xvoland/Extract)
extract() {
  SAVEIFS=$IFS
  IFS=$' \t\n'
  set +e # abort execution on errors

  if [ $# -eq 0 ]; then
    # display usage if no parameters given
    echo "Usage: ${C_YELLOW}extract${C_NC} <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
    echo "       ${C_YELLOW}extract${C_NC} <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"

    return 1
  fi

  while [[ $# -gt 0 ]]; do
    n="$1"
    shift

    # === STDIN ===
    if [[ "$n" == "-" ]]; then
      if [ -z "$1" ]; then
        echo "Error: must provide extension after '-' (stdin mode)"
        return 1
      fi
      ext="$1"
      shift

      tmpfile=$(mktemp "/tmp/extract.stdin.XXXXXX.$ext")
      cat >"$tmpfile"
      echo "Saved stdin to temp file: $tmpfile"
      extract "$tmpfile"
      rm -f "$tmpfile"
      continue
    fi

    # === FILE CHECK ===
    if [ ! -f "$n" ]; then
      echo "'$n' - file doesn't exist"
      continue
    fi

    case "${n%,}" in
    *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
      tar --auto-compress -xvf "$n"
      ;;
    *.lzma) unlzma "$n" ;;
    *.appimage) ./"$n" --appimage-extract ;;
    *.tar.lz4) tar --use-compress-program=lz4 -xvf "$n" ;;
    *.lz4) lz4 -d "$n" ;;
    *.tar.br) tar --use-compress-program=brotli -xvf "$n" ;;
    *.bz2) bunzip2 "$n" ;;
    *.cbr | *.rar) unrar x -ad "$n" ;;
    *.gz) gunzip "$n" ;;
    *.cbz | *.epub | *.zip) unzip "$n" ;;
    *.z) uncompress "$n" ;;
    *.7z | *.apk | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar | *.vhd)
      7z x "$n"
      ;;
    *.xz) unxz "$n" ;;
    *.exe) cabextract "$n" ;;
    *.cpio) cpio -id <"$n" ;;
    *.cba | *.ace) unace x "$n" ;;
    *.zpaq) zpaq x "$n" ;;
    *.arc) arc e "$n" ;;
    *.cso) ciso 0 "$n" "$n.iso" && extract "$n.iso" && rm -f "$n" ;;
    *.zlib) zlib-flate -uncompress <"$n" >"${n%.*zlib}" && rm -f "$n" ;;
    *.dmg)
      mnt_dir=$(mktemp -d)
      hdiutil mount "$n" -mountpoint "$mnt_dir"
      echo "Mounted at: $mnt_dir"
      ;;
    *.tar.zst) tar -I zstd -xvf "$n" ;;
    *.zst) zstd -d "$n" ;;
    *)
      echo "${C_RED}❌ '$n' cannot be extracted via extract().${C_NC}"
      echo "${C_RED}❌ '$n' is not a valid file.${C_NC}"
      continue
      ;;
    esac
  done
  echo "${C_GREEN}✅ Extraction complete!${C_NC}"

  IFS=$SAVEIFS
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
            "$HOME/coding"
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
    #echo -e "\n${BRed}CPU info :$NC "; cat /proc/cpuinfo ;
    echo -e "\n"
}

### set common functions
#############
function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"
precmd_functions+=(set_win_title)

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

# function nvims() {
#   items=("default" "nvim-2025" "nvim-onlyati" "nvim-2026")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0 --preview-window=hidden)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config nvim $@
# }


# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    last_dir="$(lf -print-last-dir)"
    cd "$last_dir"
}

# Inspect a port and optionally terminate the process using it
port() {
	if [[ "$1" == "help" || "$1" == "-h" || -z "$1" ]]; then
		echo "${C_CYAN}🔌 port${C_NC}: See what's running on a port and optionally kill it."
		echo "Usage: ${C_YELLOW}port <number> [kill]${C_NC}"
		echo "Examples:"
		echo "  port 8080       (Views processes on port 8080)"
		echo "  port 3000 kill  (Kills the process running on port 3000)"
		return 0
	fi

	local target_port=$1
	if [[ "$2" == "kill" ]]; then
		echo "${C_RED}Attempting to kill process on port $target_port...${C_NC}"
		local pid=$(lsof -t -i:"$target_port")
		if [[ -n "$pid" ]]; then
			kill -9 $pid
			echo "${C_GREEN}✅ Process $pid killed successfully.${C_NC}"
		else
			echo "${C_YELLOW}⚠️  No process found running on port $target_port.${C_NC}"
		fi
	else
		echo "${C_CYAN}Processes listening on port $target_port:${C_NC}"
		lsof -i :"$target_port" || echo "${C_YELLOW}No active processes on this port.${C_NC}"
	fi
}

# Display local, public, and approximate geolocation information for your IP
myip() {
	if [[ "$1" == "help" || "$1" == "-h" ]]; then
		echo "${C_CYAN}🌐 myip${C_NC}: Fetches your networking info."
		echo "Usage: ${C_YELLOW}myip${C_NC}"
		return 0
	fi

	echo "${C_CYAN}Fetching IP details...${C_NC}"
	local local_ip=$(route -n get default 2>/dev/null | grep 'interface:' | awk '{print $2}' | xargs ipconfig getifaddr 2>/dev/null)
	[[ -z "$local_ip" ]] && local_ip="127.0.0.1"
	local public_ip=$(curl -s https://ifconfig.me)
	local geo_info=$(curl -s "https://ipinfo.io/${public_ip}/city")
	local country_info=$(curl -s "https://ipinfo.io/${public_ip}/country")

	echo "🏠 ${C_YELLOW}Local IP:${C_NC}  $local_ip"
	echo "🌍 ${C_YELLOW}Public IP:${C_NC} $public_ip"
	echo "📍 ${C_YELLOW}Location:${C_NC}  $geo_info, $country_info"
}

# Measure HTTP request timing and connection latency for a URL
pingmap() {
	if [[ "$1" == "help" || "$1" == "-h" || -z "$1" ]]; then
		echo "${C_CYAN}📍 pingmap${C_NC}: Detailed connection latency breakdown."
		echo "Usage: ${C_YELLOW}pingmap <url> ${C_NC}"
		echo "Example: pingmap google.com"
		return 0
	fi

	local url="$1"

	# Prepend https:// when the URL has no scheme
	[[ "$url" != http* ]] && url="https://$url"

	echo "${C_CYAN}Mapping network route to: $url${C_NC}"
	echo "----------------------------------------"
	curl -w "  HTTP Status   : %{http_code}\n  DNS Lookup    : %{time_namelookup}s\n  TCP Connect   : %{time_connect}s\n  TLS Handshake : %{time_appconnect}s\n  Pre-Transfer  : %{time_pretransfer}s\n  First Byte    : %{time_starttransfer}s\n----------------------------------------\n  ${C_GREEN}Total Time    : %{time_total}s${C_NC}\n\n" -o /dev/null -s "$url"
}

# Fetch terminal weather and forecast information with optional display formats
weather() {
	if [[ "$1" == "help" || "$1" == "-h" ]]; then
		echo "${C_CYAN}☁️  weather${C_NC}: Advanced terminal weather and forecast."
		echo "Usage: ${C_YELLOW}weather [options] [location]${C_NC}"
		echo ""
		echo "Options:"
		echo "  ${C_YELLOW}-s, --short${C_NC}    Single-line compact format (Temp & Condition)"
		echo "  ${C_YELLOW}-o, --oneline${C_NC}  Rich single-line format (Temp, Wind, Humidity)"
		echo "  ${C_YELLOW}-f, --forecast${C_NC} Detailed visual graph forecast"
		echo "  ${C_YELLOW}-m, --moon${C_NC}    Show current moon phase"
		echo ""
		echo "Examples:"
		echo "  weather London          (Default 3-day text forecast)"
		echo "  weather -o New York     (One-line rich weather)"
		echo "  weather -f              (Detailed forecast for your current IP)"
		return 0
	fi

	local format=""
	local args=()

	for arg in "$@"; do
		case "$arg" in
			-s|--short) format="?format=3" ;;
			-o|--oneline) format="?format=4" ;;
			-f|--forecast) format="?format=v2" ;;
			-m|--moon) format="?Moon" ;;
			-*)
				echo "${C_RED}❌ Unknown option: $arg${C_NC}"
				echo "Run ${C_YELLOW}weather -h${C_NC} for usage."
				return 1
				;;
			*) args+=("$arg") ;;
		esac
	done

	local loc="${args[*]}"
	loc="${loc// /+}"

	echo "${C_CYAN}Fetching weather data...${C_NC}"
	curl -s "https://wttr.in/${loc}${format}"
}
