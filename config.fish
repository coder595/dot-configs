# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

#Path of the file ~/.config/fish/config.fish

set fish_greeting #Suppres the Welcome greeting.

set auth 'doas'

alias ls='ls --color=auto'
alias fdisk='$auth fdisk -l'
alias df='df -h'
alias c='clear'
alias at='alacritty-themes'
alias ..='cd ..'

alias mkinstall='$auth make clean install'
alias mkuninstall='$authmake clean uninstall'

alias mount='$auth mount'
alias umount='$auth umount'

alias psearch='pacman -Ss'
alias pinstall='$auth pacman -S'
alias premove='$auth pacman -Rns'
alias pinfo='pacman -Si'

alias ysearch='yay -Ss'
alias yinstall='yay -S'
alias yremove='yay -Rns'
alias yinfo='yay -Si'

alias cp='cp -i'
alias rm='rm -i'

alias rofi='rofi -show run'

alias brightness='$auth brillo -q -A 5'
alias brightless='$auth brillo -q -U 5'

alias bio-class='chromium http://demo.polr.me/1'
alias wapp='chromium https://web.whatsapp.com'

colorscript random
pfetch 

# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status is-interactive
#   ...
# end
#starship init fish | source
