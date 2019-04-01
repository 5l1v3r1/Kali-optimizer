#!/bin/bash
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
#OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"

echo -e $YELLOW"[ + ] Making few adjustments"$ENDCOLOR
echo -e "y" | tracker daemon -k
echo -e "y" | tracker reset -r
sed -i -- 's/X-GNOME-Autostart-enabled=true/X-GNOME-Autostart-enabled=false/g' /etc/xdg/autostart/tracker-miner-fs.desktop
sed -i -- 's/X-GNOME-Autostart-enabled=true/X-GNOME-Autostart-enabled=false/g' /etc/xdg/autostart/tracker-store.desktop 
 
echo -e $YELLOW"[ + ] Clearing all the bad things"$ENDCOLOR
sudo apt clean
sudo apt purge $OLDCONF
sudo apt purge $OLDKERNELS
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
echo -e $YELLOW"Done."$ENDCOLOR