#!/bin/sh

#Install tools
yay -Sy --needed --noconfirm zsh vim emacs lf vifm ranger ueberzug
yay -Sy --needed --noconfirm fzf ripgrep exa

#install Fonts
yay -Sy --needed --noconfirm nerd-fonts-hack
yay -Sy --needed --noconfirm nerd-fonts-fira-code
yay -Sy --needed --noconfirm nerd-fonts-source-code-pro
yay -Sy --needed --noconfirm nerd-fonts-jetbrains-mono

#install Starship
curl -sS https://starship.rs/install.sh | sh

#DONE

