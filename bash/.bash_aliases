docker() {
 if [[ $@ == "ps" ]]; then
  command docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
 elif [[ $@ == "stats" ]]; then
  command docker stats --format "table {{.Name}}\t{{.Container}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
 else
  command docker "$@"
 fi
}

alias lss='ls -cvA --block-size=K --group-directories-first -1 --color=always'

alias gl='git log --pretty=format:"%h %C(magenta)%ad | %C(white)%s%d %C(magenta)[%an]" --date=short --graph --max-count=40 $*'
alias gs='git status'
alias ga='git add .'
alias gco='git commit -m $*'
alias push='git push'
alias pull='git pull'

alias pro='cd /home/eddie/docker-repo' # Project Dir

alias subl='subl.exe $*'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

