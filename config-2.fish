# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

#Path of the file ~/.config/fish/config.fish


set fish_greeting #Suppres the Welcome greeting.

#fastfetch
# pfetch

set auth 'sudo'

set browser 'floorp'

#alias ls='ls --color=auto'

alias la='eza --icons=always -a --group-directories-first --sort=extension --sort=type'
alias ll='eza --icons=always -a --group-directories-first -l --sort=extension --sort=type'
alias ls='eza --icons=always --group-directories-first --sort=extension --sort=type'

#
alias v='nvim'
alias vim='nvim'
alias svim='sudo nvim'

alias efish='nvim ~/.config/fish/config.fish'
alias sfish='source ~/.config/fish/config.fish'

# alias chmod commands
#alias mx='chmod a+x'
#alias 000='chmod -R 000'
#alias 644='chmod -R 644'
#alias 666='chmod -R 666'
 alias 755='chmod -R 755'
#alias 777='chmod -R 777'

#
alias fdisk='$auth fdisk -l'
alias t='tree'
alias df='df -h'
alias c='clear'
alias at='alacritty-themes'
alias ..='cd ../ && eza --icons=always -a --group-directories-first --sort=extension --sort=type'
alias ...='cd ../.. && eza --icons=always -a --group-directories-first --sort=extension --sort=type'
alias ....='cd ../../.. && eza --icons=always -a --group-directories-first --sort=extension --sort=type'

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

if status is-interactive; and command -q stty
    stty -ixon
end

function gpush
    if test (count $argv) -eq 0
        echo "Usage: gpush \"commit message\""
        return 1
    end
    git add .
    git commit -m "$argv"
    git push origin main
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
