

#####################
# FIRST PROMPT LINE #
#####################
red='\e[1;34m'
NC='\e[0m'
echo -e "${red}Debian${NC}" `cat /etc/debian_version` "| ${red}ZSH${NC} ${ZSH_VERSION}"

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

export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

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
 pick"z.sh" \
    knu/z \
 zdharma-continuum/history-search-multi-word \

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
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|emacs|nano|vi|vim):*' fzf-preview 'exa -1 --color=always $realpath 2>/dev/null|| ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
       fzf-preview 'echo ${(P)word}'

# Autocomplete hidden files
#zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'

# case insensitive path-completion
#zstyle ':completion:*' matcher-list                       \
#'m:{[:lower:][:upper:]}={[:upper:][:lower:]}'             \
#'m:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
#'m:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
#'m:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

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

# Completion Style
#zstyle ':completion:*:*:cd:*'          ignore-parents parent pwd
#zstyle ':completion:*:*:cd:*'          tag-order local-directories directory-stack path-directories
#zstyle ':completion:*:*:cd:*'          menu yes select

# Avoid twice the same element on rm
zstyle ':completion:*:rm:*'            ignore-line yes

# Insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions

# History
zstyle ':completion:*:history-words'   list false
zstyle ':completion:*:history-words'   menu yes
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

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

# EXA
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa
zinit ice wait blockf atpull'zinit creinstall -q .'

# BAT
zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat

# FORGIT
zinit ice wait lucid
zinit load 'wfxr/forgit'

# LAZYGIT
zinit ice lucid wait"0" as"program" from"gh-r" mv"lazygit* -> lazygit" atload"alias lg='lazygit'"
zinit light 'jesseduffield/lazygit'

# LAZYDOCKER
zinit ice lucid wait"0" as"program" from"gh-r" mv"lazydocker* -> lazydocker" atload"alias ld='lazydocker'"
zinit light 'jesseduffield/lazydocker'

# dotbare
#zinit light kazhala/dotbare

# RANGER
#zinit ice depth'1' as"program" pick"ranger.py"
#zinit light ranger/ranger

# FD
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit for \
    OMZP::common-aliases \
    OMZL::correction.zsh \
    OMZL::directories.zsh \
    OMZL::key-bindings.zsh \
    OMZL::theme-and-appearance.zsh

zinit snippet OMZ::plugins/debian/debian.plugin.zsh
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit ice wait'!'
zinit wait lucid for \
    OMZP::colored-man-pages \
    OMZP::cp \
    OMZP::git \
    OMZP::sudo

# Diff so fancy
zinit ice as"program" pick"bin/git-dsf"
zinit light "zdharma-continuum/zsh-diff-so-fancy"

zinit light "srijanshetty/docker-zsh"
zinit light "supercrabtree/k"
zinit light "le0me55i/zsh-extract"
#zinit load "trapd00r/LS_COLORS"
#zinit load "zpm-zsh/ssh"
zinit light "jreese/zsh-titles"
zinit wait lucid light-mode depth"1" for \
    zsh-users/zsh-history-substring-search \
    agkozak/zsh-z

zinit light "MichaelAquilina/zsh-you-should-use"
zinit load "andrewferrier/fzf-z"
zinit light "b4b4r07/enhancd"
zinit load "chrissicool/zsh-256color"
zinit load "unixorn/fzf-zsh-plugin"

#####################
# EnhanCD           #
#####################
export ENHANCD_FILTER="fzf --height 40% --reverse --ansi"
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HOME=0

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$ZDOTDIR/.zsh_history"
export HIST_STAMPS="dd.mm.yyyy"
export HISTSIZE=100000000000
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
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
setopt completealiases        # complete alisases
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt correct                # spelling correction for commands
#setopt nocorrect              # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
#setopt vi
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt appendhistory
setopt AUTO_CD                # Navigate without typing cd
setopt globdots
setopt mark_dirs

setopt BANG_HIST              # Treat '!' char specially during expansion.
setopt CHASE_LINKS            # Resolve links to their location
setopt EXTENDED_HISTORY       # Use history ":start:elapsed;command" format.
setopt HASH_CMDS              # Dont search for commands
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording.
setopt HIST_SAVE_NO_DUPS      # Don't write dupes in the history file.
setopt INTERACTIVE_COMMENTS   # Allow comments in readlin
setopt LIST_ROWS_FIRST        # Rows are way better
setopt LIST_TYPES             # Append type chars to files
setopt MULTIOS                # Write to multiple descriptors
setopt PROMPTSUBST            # Enable param and arithmetic substitution
setopt RC_QUOTES              # Allow 'Henry''s Garage'
setopt shwordsplit            # Word splits like Bash
setopt SHORT_LOOPS            # Sooo lazy: for x in y do cmd
unsetopt FLOW_CONTROL         # Disable /stop characters editor


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
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -NC {} | less)) || echo {} 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS='--preview="ls {}" --preview-window=right:60%:wrap'
#export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
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
--color=fg:-1,bg:-1,hl:#C678DD,fg+:#FFFFFF,bg+:#4B5263,hl+:#D858FE
--color=info:#98C379,prompt:#61AFEF,pointer:#BE5046,marker:#E5C07B,spinner:#61AFEF,header:#61AFEF
'
#--color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
#--color=fg+:#e5e9f0,bg+:#2e3440,hl+:#81a1c1
#--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
#--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

source ~/.cache/zsh-shortcuts

function ranger-cd() {
    tempfile=$(mktemp /tmp/${tempfoo}.XXXXXX)
        ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
            test -f "$tempfile" &&
                   if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile" > /dev/null 2>&1
}


#Starship prompt
eval "$(starship init zsh)"


