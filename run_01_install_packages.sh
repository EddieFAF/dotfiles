#!/bin/sh

#Install tools
yay -S zsh vim emacs lf vifm ranger ueberzug
yay -S fzf ripgrep exa

#install Fonts
yay -S nerd-fonts-hack nerd-fonts-fira-code nerd-fonts-source-code-pro nerd-fonts-jetbrains-mono

#install Starship
curl -sS https://starship.rs/install.sh | sh

#DONE

