#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias c='clear'
alias at='alacritty-themes'

alias mkinstall='sudo make clean install'
alias mkuninstall='sudo make clean uninstall'

alias psearch='pacman -Ss'
alias pinstall='sudo pacman -S'
alias premove='sudo pacman -Rns'
alias pinfo='pacman -Si'

alias ysearch='yay -Ss'
alias yinstall='yay -S'
alias yremove='yay -Rns'
alias yinfo='yay -Si'

alias cp='cp -i'
alias rm='rm -i'

alias brightness='sudo brillo -q -A 5'
alias brightless='sudo brillo -q -U 5'

# Install it from AUR shell-color-scripts OR (https://gitlab.com/dwt1/shell-color-scripts)
 colorscript random
 pfetch

PS1='[\u@\h \W]\$ '
# eval "$(starship init bash)"
