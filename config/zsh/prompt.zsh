# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config $ZDOTDIR/default.omp.toml)"
