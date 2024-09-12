# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

zinit light junegunn/fzf
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q
zi ice depth=1; zi light romkatv/powerlevel10k

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd extendedglob nomatch menucomplete

export EDITOR='nvim'

set termguicolors

# Completion styling
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

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

#############
## FZF-TAB ##
#############
zstyle ':fzf-tab:*' prefix ''

zstyle ':fzf-tab:complete:*' popup-pad 200 50

#zstyle ':fzf-tab:complete:*:*' fzf-flags --preview=$extract";$PREVIEW \$in"

zstyle ':fzf-tab:complete:_zlua:*' query-string input

#zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Preview directory's content with exa
#zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --long --header --icons --group-directories-first --group --git --all --links --color=always $realpath'
#zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'

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
# FZF SETTINGS      #
#####################
export FZF_DEFAULT_OPTS="--ansi"
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
#'
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_TMUX_HEIGHT="80%"
export FZF_DEFAULT_OPTS="
 --prompt='~ ❯ '
 --height='80%'
 --marker='✗'
 --pointer='▶'
 --border
 --inline-info
 --layout=reverse
 --preview                                                                 \
     '([[ -f {} ]] &&                                                      \
     (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && \
     (exa --tree --icons --color=always {} | less)) || echo {} 2> /dev/null | head -200'"
#export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_COMPLETION_TRIGGER="**"

source ~/.cache/zsh-shortcuts

# Aliases
source $ZDOTDIR/aliases
alias c='clear'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

function nvims() {
  items=("default" "mvim" "nvim-pkazmier" "nvim-231trOn")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0 --preview-window=hidden)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
