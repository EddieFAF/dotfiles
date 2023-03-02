
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
# FIRST PROMPT LINE #
#####################
red='\e[1;34m'
NC='\e[0m'
echo -e "${red}ArcoLinux${NC}" `cat /version` "| ${red}ZSH${NC} ${ZSH_VERSION}"

#####################
# ZINIT             #
#####################
### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p $HOME/.config/zsh/.zinit
    command git clone https://github.com/zdharma-continuum/zinit $HOME/.config/zsh/.zinit/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

fpath=($HOME/.config/zsh $fpath)


# HISTORY SUBSTRING SEARCHING
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

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

# TAB COMPLETIONS
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select=2
zstyle ':completion:*' completer _complete _expand _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# case insensitive path-completion
zstyle ':completion:*' matcher-list                       \
'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'             \
'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*'                list-suffixes
zstyle ':completion:*'                expand prefix suffix

# speedup path completion
zstyle ':completion:*'                accept-exact '*(N)'
zstyle ':completion:*'                use-cache on
zstyle ':completion:*'                cache-path ${CACHE}/zsh
zstyle ':completion:*'                use-perl on

# colors
zstyle ':completion:*:default'        list-colors '${(s.:.)LS_COLORS}'

# manuals
zstyle ':completion:*:manuals'        separate-sections true
zstyle ':completion:*:manuals.(^1*)'  insert-sections   true
zstyle ':completion:*:man:*'          menu yes select

# Fuzzy match mistyped completions.
zstyle ':completion:*'                completer _complete _list _match _approximate
zstyle ':completion:*:match:*'        original only
zstyle ':completion:*:approximate:*'  max-errors 1 numeric

# Don't complete unavailable commands.
zstyle ':completion:*:functions'      ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions

# History
zstyle ':completion:*:history-words'   list false
zstyle ':completion:*:history-words'   menu yes
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

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


# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# FD
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit ice wait'!'
zinit snippet OMZP::colored-man-pages

zinit light "supercrabtree/k"
zinit light "le0me55i/zsh-extract"

#zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
#    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
#zinit light trapd00r/LS_COLORS

zinit load "agkozak/zsh-z"
zinit light "MichaelAquilina/zsh-you-should-use"
zinit load "andrewferrier/fzf-z"
zinit load "chrissicool/zsh-256color"
zinit load "unixorn/fzf-zsh-plugin"

zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma-continuum/zsh-diff-so-fancy

#Powerlevel10k Theme
#zinit ice depth=1; zinit light romkatv/Powerlevel10k

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$ZDOTDIR/.zsh_history"
export HIST_STAMPS="dd.mm.yyyy"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
export ZSH_PECO_HISTORY_OPTS="--layout=bottom-up --initial-filter=Fuzzy"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#####################
# FZF SETTINGS      #
#####################
export FZF_BASE=$(which fzf)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS='--preview="ls {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--exit-0
--cycle
--bind=ctrl-j:accept
--height=80%
--layout=reverse
--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -500"
--info=inline
--bind "?:toggle-preview"
--pointer=">"
--color=dark
--color=fg:-1,bg:-1,hl:#5AF78E,fg+:-1,bg+:#4D4D4D,hl+:#f1FA8C
--color=info:#BD93F9,prompt:#5AF78E,pointer:#ff79C6,marker:#ff79C6,spinner:#ff79C6
'
#--color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
#--color=fg+:#e5e9f0,bg+:#2e3440,hl+:#81a1c1
#--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
#--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'


function ranger-cd() {
    tempfile=$(mktemp /tmp/${tempfoo}.XXXXXX)
    ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile" > /dev/null 2>&1
}

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

source ~/.cache/zsh-shortcuts

export EDITOR='nvim'

#function set_win_title(){
#    echo -ne "\033]0; $(basename "$PWD") \007"
#}
#starship_precmd_user_func="set_win_title"
#precmd_functions+=(set_win_title)

#Starship prompt
eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
