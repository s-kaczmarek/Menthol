#!/bin/bash

# This script covers steps presented in articule: https://sites.google.com/site/easylinuxtipsproject/mint-cinnamon-first#TOC-TEN-ESSENTIAL-ACTIONS:

#TODO
#MENU:
#1. Run Minthol script
#2. Utilities
#3. Restore to defaults

#Utilities
#
#1. Fix panel icons
#
#

############################################
#TODO                                      #
# - menu                                   #
# 1. Post-install steps                    #
# 2. Mint upgrade with mintupgrade package #
# 3. Restore to defaults                   #
#                                          #
############################################


echo -e "\e[0;32m Make sure, that you are connected to the internet and continue. \e[0m" 
read -n1 -r -p "Press any key to continue..." key


# ------------
# -  SYSTEM  -
# ------------


# enable recommended packages installation
sudo mv -v /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled   # This operation will enable recommended packages installation. You can easyly revert this opperation by changing file name to previous one.
echo -e "\e[0;32m recommended packages installation enabled \e[0m" 

# update packages list
sudo apt update
echo -e "\e[0;32m list of available packages updated \e[0m"

# upgrade packages
sudo apt upgrade
sudo apt dist-upgrade

# update manager settings
echo -e "\e[0;32m now the update manager will pop up, please change update policy to: -Let me review sensitive updates- and change mirrors for fastest for you. When you finnish, please close update manager and continue \e[0m"
gksudo mintupdate
read -n1 -r -p "Press any key to continue..." key

# drivers
echo -e "\e[0;32m now the driver manager will pop up, please review if you have any drivers available, enable them if you want, enable microcode (this is optional, recommended only when you have noticed some issues with CPU). If you are being offered several versions of Nvidia drivers, start with number one, and if you notice some issues later on, change to number 2, 3 etc. When finnished, please close update manager and continue \e[0m" 
driver-manager
read -n1 -r -p "Press any key to continue..." key

# installation of full multimedia support
# TODO make auto check if multimedia support was installed with system
echo -e "\e[0;32m - Installation of full multimedia support - \e[0m"
echo -e "\e[0;32m If you have ticked checkbox for - Install third-party software for graphics and Wi-Fi hardware... - please skip this step! \e[0m" 
echo ""
echo -e "\e[0;36m 1) I want to skip this step! \e[0m"
echo -e "\e[0;36m 2) Install full multimedia support \e[0m"

while read one_or_two; do
    case "$one_or_two" in
        "1") break ;;
        "2") echo "Installing full multimedia support";
             sudo apt install libdvd-pkg ;
             sudo dpkg-reconfigure libdvd-pkg ; 
             break ;;
          *) echo "Wrong input! Type 1 or 2" ;        
    esac
done

# ssd optimalization - https://sites.google.com/site/easylinuxtipsproject/ssd
# TODO find solution for multiple drives
echo -e "\e[0;32m First we will check if you have ssd or hdd drive \e[0m"
ssd_check="$( cat /sys/block/sda/queue/rotational )"
case "$ssd_check" in
    "0") echo -e "\e[0;32m you have ssd drive, so we will optimaze that \e[0m" ;
         # noatime
         #TODO add noatime automaticly with sed, use code bellow for check (look at I/O scheduler as example)
         echo -e "\e[0;32m fstab file will open in xed text editor. Add \"noatime,\" right before \"errors=remount-ro 0 1\" \e[0m" ;
         echo -e "\e[0;32m This line has to look like this: \e[0m" ;
         echo -e "\e[0;32m UUID=xxxxxxx / ext4 noatime,errors=remount-ro 0 1 \e[0m" ;
         echo -e "\e[0;32m When you finish, save file, close text editor and continue \e[0m" ;
         gksudo xed /etc/fstab ;
         read -n1 -r -p "Press any key to continue..." key ;
         # trimming
         echo -e "\e[0;32m Now we will change trimming from weekly to daily schedule in cron \e[0m" ;
         sudo mv -v /etc/cron.weekly/fstrim /etc/cron.daily ; # if you want to undo this operation simply: sudo mv -v /etc/cron.daily/fstrim /etc/cron.weekly
         # swap limit
         echo -e "\e[0;32m Now we will check if the swap limit is set to correct value for not overusing SSD \e[0m"
         swap_check="$( head -1 /proc/sys/vm/swappiness )"
         if [ "$swap_check" -gt 1 ]; then
              #MANUAL VERSION v
              echo -e "\e[0;32m Swap limit is set to "$swap_check" which is to high. We have to reduce it to 1 \e[0m" 
              echo -e "\e[0;32m To do so, we will open /proc/sys/vm/swappiness file and please write those two lines at the end of this file: \e[0m"
              echo -e "\e[0;32m # Sharply reduce the inclination to swap \e[0m"
              echo -e "\e[0;32m vm.swappiness=1 \e[0m"
              gksudo xed /proc/sys/vm/swappiness
              echo -e "\e[0;32m When you finish, save file, close text editor and continue \e[0m"
              read -n1 -r -p "Press any key to continue..." key ;
              #AUTOMATIC version - not working! v            
              #sudo echo "# Sharply reduce the inclination to swap" >> /proc/sys/vm/swappiness  #add this lines to reduce swap
              #sudo echo "vm.swappiness=1" >> /proc/sys/vm/swappiness
              #TODO ^ sudo echo doesn't work, I have tried with command: echo "some text here" | sudo tee -a /proc/.../swappiness with no success to

         else
              :
         fi
         # disable hibernation https://sites.google.com/site/easylinuxtipsproject/bugs#TOC-Hibernate-and-suspend-don-t-always-work-well:-they-make-some-computers-malfunction-or-even-enter-a-coma
         echo -e "\e[0;32m this step will disable hibernation which will reduce hdd usage, you will be still able to use \"suspend\", \e[0m" 
         echo -e "\e[0;32m it takes more energy in compare to \"hibernate \", but saves your ssd. You can olways undo this operation later or skip this step \e[0m"
         echo -e "\e[0;32m would you like to procede? [y/n] \e[0m"
         while read y_n; do
             case "$y_n" in
              [Yy]* ) sudo mv -v /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla / # com.ubuntu.enable-hibernate.pkla will be moved to / to undo simply move it back again to /etc/polkit-1/localauthority/50-local.d/
                      echo -e "\e[0;32m hibernation disabled \e[0m" 
                      break ;;                                                                              
              [Nn]* ) echo -e "\e[0;32m hibernation remains enabled \e[0m"
                      break ;; 
                   *) echo -e "\e[0;31m Wrong input! Type y or n \e[0m" ;        
             esac
         done
         # I/O scheduler setting to deadline http://www.techrepublic.com/article/how-to-change-the-linux-io-scheduler-to-fit-your-needs/
         echo -e "\e[0;32m First we will check if I/O is already set to \"deadline\" \e[0m"
         IO_check="$ ( cat /sys/block/sda/queue/scheduler )" #TODO Make some kind of check if linux is realy installed on sda
         case "$IO_check" in
            *[deadline]* ) echo -e "\e[0;32m I/O scheduler is already set to \"deadline\", moving to the next step \e[0m";;
                        *) sudo sed -i 's/\quiet splash\b/& elevator=deadline/' /etc/default/grub ;
                           sudo update-grub ;
                           IO_check="$ ( cat /sys/block/sda/queue/scheduler )" #Checking if operation ended propperly
                           case "$IO_check" in
                              *[deadline]* ) echo -e "\e[0;32m I/O scheduler has been successfully set to \"deadline\", moving to the next step \e[0m";;
                                          *) echo -e "\e[0;32m I/O something went wrong, please add manually \"elevator=deadline\" right after \"quiet splash\" \e[0m";
                                             echo -e "\e[0;32m It has to look like this: GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash elevator=deadline\" \e[0m";
                                             gksudo xed /etc/default/grub ;
                                             echo "When you finish, save file, close text editor and continue" ;
                                             read -n1 -r -p "Press any key to continue..." key ;;
                           esac
         esac
         ;;
    "1") echo -e "\e[0;32m you have hdd, skipping to the next step... \e[0m" ;;
      *) echo echo -e "\e[0;31m ERROR!!! Wrong output from disc type check \e[0m" ;
esac

# automounting additional partitions #TODO test whole section
# this section doesn't work right now, probably becaus encrypted /home
echo -e "\e[0;32m Is there any partition that you would like to automount on startup? \e[0m"
echo -e "\e[0;32m Example: \" Data \" partition shared with other operating system on this computer \e[0m"
echo -e "\e[0;32m [y/n] \e[0m"
while read y_n; do
    case "$y_n" in
     [Yy]* ) echo -e "\e[0;32m You can see list of all partitions below: \e[0m" ;
             ls -l /dev/disk/by-label ;
             echo -e "\e[0;32m Please type name of partition that you would like to automount. Example: sda5 \e[0m" ;
             while read partition; do
                 case "$partition" in
                    [sd*]* ) echo -e "\e[0;32m Please also rewrite partition label \e[0m" ;
                             read label
                             echo -e "\e[0;32m Partition "$partition" will be set to automount on startup \e[0m" ; #TODO check if partition is typed correctly (compare with /dev/sd..)
                             touch ~/automount_$partition.sh ; 
                             #sudo mkdir /media/$USER/$label ; #not sure if this is correct - maybe this folder will be created auto.
                             #writing script into file v
                             sudo echo  "### BEGIN INIT INFO" >> ~/automount_$partition.sh ;
                             sudo echo  "# Providers:            scriptname" >> ~/automount_$partition.sh ;
                             sudo echo  "# Required-Start:       '$remote_fs' '$syslog'" >> ~/automount_$partition.sh ;
                             sudo echo  "# Required-Stop:        '$remote_fs' '$syslog'" >> ~/automount_$partition.sh ;
                             sudo echo  "# Default-Start:        2 3 4 5" >> ~/automount_$partition.sh ;
                             sudo echo  "# Default-Stop:         0 1 6" >> ~/automount_$partition.sh ;
                             sudo echo  "# Short-Description:    Start daemon at boot time" >> ~/automount_$partition.sh ;
                             sudo echo  "# Description:          Enable service provider by daemon" >> ~/automount_$partition.sh ;
                             sudo echo  "### END INIT INFO" >> ~/automount_$partition.sh ;
                             sudo echo  "#!/bin/bash" >> ~/automount_$partition.sh ;
                             sudo echo  "" >> ~/automount_$partition.sh ;
                             sudo echo  "mount -t ntfs /dev/$partition /media/$USER/$label" >> ~/automount_$partition.sh ;
                             sudo echo  "" >> ~/automount_$partition.sh ;
                             sudo echo  "exit 0" >> ~/automount_$partition.sh ;
                             sudo chmod 777 ~/automount_$partition.sh ; #try with: sudo chmod u=rwxr,g=xr,o=x automount_sda5.sh
                             sudo chown root:root ~/automount_$partition.sh ;
                             sudo mv -v ~/automount_$partition.sh /etc/init.d/ ;
                             break ;;
                          *) echo -e "\e[0;31m Wrong input! Type correct partition name! \e[0m" ;
                  esac
             done
             break ;;
     [Nn]* ) echo -e "\e[0;32m Going to the next step... \e[0m" ;
             break ;;
         * ) echo -e "\e[0;31m Wrong input! Type correct partition name! \e[0m" ;
    esac
done

#Turn on the firewall
echo -e "\e[0;32m firewall is disabled by default, but usually it's better to turn it on. Especially on mobile devices like laptops, which sometimes connect to other networks than your own. \e[0m"
sudo ufw enable
sudo ufw status verbose

#Set root password
echo -e "\e[0;32m Starting with Linux Mint 18.2, the root password is unfortunately no longer set by default \e[0m"
echo -e "\e[0;32m This means that a malicious person with physical access to your computer, can simply boot it into Recovery mode. In the recovery menu he can then select to launch a root shell, without having to enter any password. \e[0m"
echo -e "\e[0;32m I advise to make the root password identical to your own. Prepare to set your root password \e[0m"
sudo passwd


             


# system tools installation

sudo apt install htop -y
sudo apt install atop -y
sudo apt install gparted -y
sudo apt install mc -y
sudo apt install encfs -y
sudo apt install leafpad -y
sudo apt install pavucontrol -y
sudo apt install catfish -y
sudo apt install diodon -y
sudo apt install openvpn -y
sudo apt install clamav clamtk libclamunrar7 clamav-freshclam clamav-daemon -y
sudo apt install conky-all -y
sudo apt install redshift redshift-gtk geoclue-2.0 -y #TODO setup and autostart
sudo apt install screenfetch -y
sudo apt install virtualbox -y #needs virtualbox-qt (should install after enabling recommended packages)
sudo apt install caffeine -y 
#add caffeine to autostart
sudo apt install dconf-cli -y
sudo apt install dconf-editor -y
sudo apt install keepass2 xdotool mono-complete -y #xdotool allows to autopaste passwords, mono-complete allows plugins to work
#wget https://bitbucket.org/devinmartin/keecloud/downloads/KeeCloud-1.2.0.3.plgx #plugin for keepass2
#sudo mkdir /usr/lib/keepass2/plugins/ #making directory for keepass2 plugins
#sudo mv -v KeeCloud-1.2.0.3.plgx /usr/lib/keepass2/plugins/ #installing plugin
#^ not working to delete, delete also mono-complete
sudo apt install baobab -y





# apletts

# install from: https://cinnamon-spices.linuxmint.com/applets

# cinnamenu
# weather

# internet & communication

    #restore pidgin settings
    #yakyak
    #desktop messenger
## Slack
echo -e "\e[0;32m Go to the site: https://slack.com/downloads/linux \e[0m"
echo -e "\e[0;32m Click on download for Ubuntu and open with GDebi. \e[0m"
read -n1 -r -p "Press any key to continue..." key

##restore thunderbird setup (test it before usage and decide on backup tree)
sudo mount /dev/$partition /media/$USER/$label
cp -vr /media/$USER/$label/Thunderbird_backup ~/.thunderbird #przenosi cały folder, a nie pliki! dodaj _backup/* ~/.thunderbird
    
# office
## dropbox
sudo apt install dropbox python-gpgme -y
## mega
cd ~/Downloads
wget https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/megasync-xUbuntu_16.04_amd64.deb
sudo gdebi megasync*


## cryptomator
wget https://bintray.com/cryptomator/cryptomator-deb/download_file?file_path=cryptomator-1.3.1-amd64.deb
#installation from repo not working!!! v
#sudo add-apt-repository ppa:sebastian-stenzel/cryptomator -y
#sudo apt-get update -y
#sudo apt-get install cryptomator -y

    #

# education

sudo apt install anki -y
    
# programming

## Brackets:
sudo add-apt-repository ppa:webupd8team/brackets -y
sudo apt-get update -y
sudo apt-get install brackets -y

## Java JDK8 #tested, works fine!
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
echo -e "\e[0;32m Setting \$JAVA_HOME in /etc/environment \e[0m"
echo -e "\e[0;32m Paste at the end of file: JAVA_HOME=/usr/lib/jvm/java-8-oracle \e[0m"
gksudo xed /etc/environment
echo -e "\e[0;32m Save file and procede \e[0m"
read -n1 -r -p "Press any key to continue..." key
#sudo echo  "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment  TODO figure out how to do it auto
source /etc/environment
echo $JAVA_HOME #check

## IntelliJ IDEA
echo -e "\e[0;32m Download Community version (tar.gz) from this site: https://www.jetbrains.com/idea/download/#section=linux \e[0m"
echo -e "\e[0;32m Make sure it is placed in ~/Downloads folder, when file is downloaded, hit enter to procede \e[0m"
read -n1 -r -p "Press any key to continue..." key
echo -e "\e[0;32m Unpacking... \e[0m"
cd ~/Downloads
tar xfz ideaIU* 
echo -e "\e[0;32m Installing... \e[0m"
bash ./idea-IU*/bin/idea.sh
echo -e "\e[0;32m Done! \e[0m"



sudo apt install vim
sudo apt install git
    
# media

    #mpd & mpd config
    #sonnata
    #ncmpcpp
    #easy tag

# graphics

    #inkscape
    #blender









## sprawdź, czy lepiej zainstalować keepassx czy keepass2

## jak dodać google search engine: https://www.systutorials.com/136954/how-to-add-google-to-firefox-in-linux-mint-as-default-search-engine/

## google drive z repo
## spideroak z repo


# THEMING
