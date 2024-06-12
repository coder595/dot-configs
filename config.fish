# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

#Path of the file ~/.config/fish/config.fish


set fish_greeting #Suppres the Welcome greeting.

#fastfetch
 pfetch

set auth 'sudo'

set browser 'floorp'

#alias ls='ls --color=auto'

alias gemini='thorium-browser https://gemini.google.com/app'
alias YT='thorium-browser https://www.youtube.com/'
alias WA='thorium-browser https://web.whatsapp.com/'

#
alias la='exa -a --sort=extension --sort=type'
alias ll='exa -al --sort=extension --sort=type'
alias ls='exa --sort=extension --sort=type'

#
alias vim='nvim'
alias svim='sudo nvim'

alias efish='vim .config/fish/config.fish'
alias sfish='source .config/fish/config.fish'

# alias chmod commands
#alias mx='chmod a+x'
#alias 000='chmod -R 000'
#alias 644='chmod -R 644'
#alias 666='chmod -R 666'
 alias 755='chmod -R 755'
#alias 777='chmod -R 777'

#
alias fdisk='$auth fdisk -l'
alias df='df -h'
alias c='clear'
alias at='alacritty-themes'
alias ..='cd ../ && exa --sort=extension --sort=type'
alias ...='cd ../.. && exa --sort=extension --sort=type'
alias ....='cd ../../.. && exa --sort=extension --sort=type'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

#
alias mkinstall='$auth make clean install'
alias mkuninstall='$auth make clean uninstall'

#
alias mount='$auth mount'
alias umount='$auth umount'

# Pacman commands
alias psearch='pacman -Ss'
alias pinstall='$auth pacman -S'
alias premove='$auth pacman -Rns'
alias pinfo='pacman -Si'

# yay commands
alias ysearch='yay -Ss'
alias yinstall='yay -S'
alias yremove='yay -Rns'
alias yinfo='yay -Si'

#
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias ps='ps auxf'
alias ping='ping -c 10'

#
alias brightness='$auth brillo -q -A 5'
alias brightless='$auth brillo -q -U 5'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

#To autostart startx when logging into the Fish shell
if status is-interactive
    # Check if DISPLAY is not set and that startx isn't already running
    if not set -q DISPLAY
        # Only execute startx if not already running in a graphical environment
        if not pgrep X > /dev/null
            exec startx
        end
    end
end


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
