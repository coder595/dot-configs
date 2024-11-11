## Path of the file /usr/local/bin/startdwm.sh
## This file should be referenced to both files in, .xinitrc & /usr/share/xsessions/dwm.desktop 
#!/bin/sh
nitrogen --restore &
picom &
slstatus &

while true; do
    # Log stderr to a file
    dwm 2> ~/.dwm.log
    # If you don't want logging, uncomment the next line and comment the one above:
    # dwm >/dev/null 2>&1
done

