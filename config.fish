# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

#Path of the file ~/.config/fish/config.fish


set fish_greeting #Suppres the Welcome greeting.

fastfetch

set auth 'sudo'

set browser 'floorp'

#alias ls='ls --color=auto'

alias office='flatpak run org.onlyoffice.desktopeditors'
alias discord='flatpak run com.discordapp.Discord'
alias tafsir='flatpak run org.gtaf.quran'

alias quran='firefox-esr https://quran.com/'
alias sunnah='firefox-esr https://sunnah.com/'
alias bukhari='firefox-esr https://sunnah.com/bukhari'
alias muslim='firefox-esr https://sunnah.com/muslim'

alias gpt='thorium-browser https://chat.openai.com/'
alias gemini='thorium-browser https://gemini.google.com/app'
alias YT='thorium-browser https://www.youtube.com/'
alias WA='thorium-browser https://web.whatsapp.com/'

alias tempe='firefox-esr https://tempmail.plus/en/#!'
alias colorp='firefox-esr https://www.w3schools.com/colors/colors_picker.asp'

alias pmtr='$browser https://www.physicsandmathstutor.com/'
alias chemr='$browser https://chemrevise.org/international-a-level/'
alias pastr='$browser https://www.paperlords.org/ial-recent-papers'
alias pastc='$browser https://www.paperlords.org/ial-recent-papers/ial-chemistry'
alias pastp='$browser https://www.paperlords.org/ial-recent-papers/ial-physics'

alias la='exa -a'
alias ll='exa -al'
alias ls='exa'

alias vim='nvim'

alias fdisk='$auth fdisk -l'
alias df='df -h'
alias c='clear'
alias at='alacritty-themes'
alias ..='cd ..'

alias mkinstall='$auth make clean install'
alias mkuninstall='$auth make clean uninstall'

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

 #colorscript random
 #figlet ==MN7==
 #pfetch 

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
