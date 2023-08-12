export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export NAVE_DIR="$HOME"/.local/lib/nodejs
export CARGO_HOME="$HOME"/.local/lib/cargo
export RUSTUP_HOME="$HOME"/.local/lib/rustup
export GOPATH="$HOME"/.local/lib/go
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.local/cache
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=/tmp}"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export GNUPGHOME="$XDG_DATA_HOME"/gpg
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME"/npm
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export KUBECONFIG="$XDG_CONFIG_HOME"/kube/config
export KUBECACHEDIR="$XDG_RUNTIME_DIR"/kube
export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship
export TFENV="$XDG_DATA_HOME"/terraform

#export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
#export HISTSIZE=290000                   # Maximum events for internal history
#export SAVEHIST=290000                   # Maximum events in history file

#####################
# ENV VARIABLE      #
#####################
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export SHELL='/bin/zsh'

export LC_COLLATE=de_DE.UTF-8
export LC_CTYPE=de_DE.UTF-8
export LC_MESSAGES=de_DE.UTF-8
export LC_MONETARY=de_DE.UTF-8
export LC_NUMERIC=de_DE.UTF-8
export LC_TIME=de_DE.UTF-8
export LANGUAGE=de_DE.UTF-8
export LESSCHARSET=utf-8

export LANG='de_DE.UTF-8'
export LC_ALL='de_DE.UTF-8'
export BAT_THEME="ansi"

export LOCATION="Uetze"

export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/zsh/.zinit/plugins/ogham---exa/bin:$HOME/.local/bin:$HOME/.local/bin/statusbar::$PATH

export QT_QPA_PLATFORMTHEME="qt5ct"
