# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


# PATH MODIFICATIONS

# Functions which modify the path given a directory, but only if the directory
# exists and is not already in the path. (Super useful in ~/.zshlocal)

_prepend_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($1 $path);
  fi
}

_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($path $1);
  fi
}

_force_prepend_to_path() {
  path=($1 ${(@)path:#$1})
}

# Note that there is NO dot directory appended!
_force_prepend_to_path /usr/local/sbin
_force_prepend_to_path /usr/local/bin
_force_prepend_to_path ~/bin
_append_to_path /usr/sbin


#####################
# ZINIT             #
#####################
### Added by Zinit's installer
# if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
#     print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
#     command mkdir -p $HOME/.config/zsh/.zinit
#     command git clone https://github.com/zdharma-continuum/zinit $HOME/.config/zsh/.zinit/bin && \
#         print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
#         print -P "%F{160}▓▒░ The clone has failed.%F"
# fi
# source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


#autoload -Uz _zinit
#(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

#fpath=($HOME/.config/zsh $fpath)


# HISTORY SUBSTRING SEARCHING
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zinit wait lucid for \
 silent atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 as"completion" \
    zsh-users/zsh-completions \
 atload"!export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=white,bold'" \
    zsh-users/zsh-history-substring-search \
 pick"zsh-interactive-cd.plugin.zsh" \
    changyuheng/zsh-interactive-cd \

# +-------------+
# | COMPLETIONS |
# +-------------+

# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

zstyle ':completion:*:*:*:*:default'  list-colors         ${(s.:.)LS_COLORS}

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*'                 use-cache           true
zstyle ':completion:*'                 cache-path          $XDG_CACHE_HOME/zsh/.zcompcache

zstyle ':completion:*'                 list-dirs-first     true
zstyle ':completion:*'                 verbose             true
zstyle ':completion:*'                 matcher-list        'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:descriptions'    format              '[%d]'
zstyle ':completion:*:manuals'         separate-sections   true
zstyle ':completion:*:git-checkout:*'  sort                false # disable sort when completing `git checkout`

# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*'                 complete            true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer           _expand_alias

# Allow you to select in a menu
zstyle ':completion:*'                 menu                select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*'                 complete-options    true

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*'          tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*'                 group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

zstyle ':completion:*'                 keep-prefix         true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Enable cached completions, if present
if [[ -d ${XDG_CACHE_HOME}/zsh/fpath ]]; then
     FPATH+=${XDG_CACHE_HOME}/zsh/fpath
     fi

export LESSOPEN='|lesspipe.sh %s'


#############
## FZF-TAB ##
#############
zstyle ':fzf-tab:*' prefix ''

zstyle ':fzf-tab:complete:*' popup-pad 200 50

zstyle ':fzf-tab:complete:_zlua:*' query-string input

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Preview directory's content with exa
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --long --header --icons --group-directories-first --group --git --all --links --color=always $realpath'

# df
zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview '[[ $group != "device label" ]] && grc --colour=on df -Th $word'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

# Parameter
zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview 'echo ${(P)word}'

# Docker
zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'docker container $word --help | bat --color=always -plhelp'
zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview 'docker image $word --help | bat --color=always -plhelp'
zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview 'docker inspect $word | bat --color=always -pljson'
zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview 'docker images $word'
zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview 'docker help $word | bat --color=always -plhelp'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Load menu-style completion.
zmodload -i zsh/complist
bindkey -M menuselect '^M' accept

#####################
# PLUGINS           #
#####################
# SSH-AGENT
zinit light bobsoppe/zsh-ssh-agent

# FZF BINARY AND TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as"command" pick"bin/fzf-tmux"
zinit light junegunn/fzf

# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# FD
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit for \
  OMZP::common-aliases \
  OMZL::correction.zsh \
  OMZL::directories.zsh \
  OMZL::key-bindings.zsh \
  OMZL::theme-and-appearance.zsh

zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit ice wait'!'
zinit wait lucid for \
  OMZP::colored-man-pages \

#zinit light "supercrabtree/k"
zinit light "le0me55i/zsh-extract"

#zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
#    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
#zinit light trapd00r/LS_COLORS

zinit wait lucid light-mode depth"1" for \
  zsh-users/zsh-history-substring-search \

zinit load "agkozak/zsh-z"
zinit light "MichaelAquilina/zsh-you-should-use"
zinit load "andrewferrier/fzf-z"
zinit load "chrissicool/zsh-256color"
zinit load "unixorn/fzf-zsh-plugin"

zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma-continuum/zsh-diff-so-fancy

#Powerlevel10k Theme
#zinit ice depth=1; zinit light romkatv/powerlevel10k

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$ZDOTDIR/.zsh_history"
export HIST_STAMPS="dd.mm.yyyy"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export ZSH_PECO_HISTORY_OPTS="--layout=bottom-up --initial-filter=Fuzzy"
export EDITOR='nvim'

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording.
setopt HIST_SAVE_NO_DUPS      # Don't write dupes in the history file.
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
setopt autocd extendedglob nomatch menucomplete

set termguicolors

# Zsh-Autosuggest
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
export ZSH_AUTOSUGGEST_USE_ASYNC="1"
export ZSH_AUTOSUGGEST_MANUAL_REBIND="1"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="1"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)


HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

#####################
# COLORING          #
#####################
autoload colors && colors

#####################
# ALIASES           #
#####################
source $ZDOTDIR/aliases


alias r="vicd ./"
vicd()
{
    local dst="$(command /usr/bin/vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
source $HOME/.config/zsh/lf_icons

######################
# nnn quit on cd     #
######################
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}

#####################
# FANCY-CTRL-Z      #
#####################
function fg-fzf() {
	job="$(jobs | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}
function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER=" fg-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

#####################
# FZF SETTINGS      #
#####################
export FZF_BASE=$(which fzf)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_DEFAULT_OPTS="--ansi"
#export FZF_DEFAULT_OPTS='--color="hl:206" --keep-right --pointer=⟐ --prompt="❱ " --ellipsis=… --scroll-off=3 --cycle --layout=reverse --height="90%"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --select-1 --exit-0
"
#export FZF_ALT_C_OPTS='--preview="ls {}" --preview-window=right:60%:wrap'
export FZF_ALT_C_OPTS="--preview 'tree -C | head -200'"
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#--exit-0
#--cycle
#--ansi
#--bind=ctrl-j:accept
#--height=40%
#--bind "?:toggle-preview"
#--color=dark
#--color=fg:-1,bg:-1,hl:#5AF78E,fg+:-1,bg+:#4D4D4D,hl+:#f1FA8C
#--color=info:#BD93F9,prompt:#5AF78E,pointer:#ff79C6,marker:#ff79C6,spinner:#ff79C6
#'
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

#--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -500"
#--color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
#--color=fg+:#e5e9f0,bg+:#2e3440,hl+:#81a1c1
#--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
#--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function ranger-cd() {
    tempfile=$(mktemp /tmp/${tempfoo}.XXXXXX)
    ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile" > /dev/null 2>&1
}

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac


# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

source ~/.cache/zsh-shortcuts


alias v="NVIM_APPNAME=nvim nvim"
alias astro="NVIM_APPNAME=nvim-astro nvim"

function nvims() {
  items=("default" "nvim-faf" "mvim" "nvim-eddie" "nvim-astro")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt="Neovim Config > " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"
precmd_functions+=(set_win_title)

#Starship prompt
eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
