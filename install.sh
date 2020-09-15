#BASE AND NECESSARY INTALLATION
sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf && sudo echo "deltarpm=true" >> /etc/dnf/dnf.conf
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y';
sudo dnf install fedora-workstation-repositories -y
sudo dnf check-update
sudo dnf install newt -y
init=""

cmd=(whiptail --separate-output --checklist "Select options:" 15 40 10)
options=(1 "Kdenlive" off    # any option can be set to default to "on"
         2 "Inkscape" off
         3 "Obs Studio" off
         4 "Firefox" off
         5 "Visual Studio Code" off
         6 "Microsoft Teams" off
         7 "Audacity" off
         8 "Gimp" off
         9 "Google Chrome" off
         10 "Discord" off)
         
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            init=$init" kdenlive"
            ;;
        2)
            init=$init" inkscape"
            ;;
        3)
            init=$init" obs-studio"
            ;;
        4)
            init=$init" firefox"
            ;;
        5)
            init=$init" code"
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            ;;
        6)
            wget -c https://go.microsoft.com/fwlink/p/\?linkid\=2112907\&clcid\=0x409\&culture\=en-us\&country\=us -O teams.rpm
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo rpm -ivh teams.rpm 
            ;;
        7)
            init=$init" audacity"
            ;;
        8)
            init=$init" gimp"
            ;;
        9)
            init=$init" google-chrome-stable"
            sudo dnf config-manager --set-enabled google-chrome
            ;;
        10)
            init=$init" discord"
            ;;
    esac
done
    if [ "$init" != "" ]; then
        echo "Instalando apps $init"
        sudo dnf check-update;
        sudo dnf install $init -y
    fi
        echo "Seu Sistema sera atualizado agora :)"
        sudo dnf upgrade -y
