#!/bin/bash


init() {

    echo -e "Finding Operating System Type..."

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo -e "Operating System : Linux GNU"
        findLinuxDistributionAndInstall
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        #Write script
        echo "Script not supported in this operating system"
        exit 1
    else
        echo "Script not supported in this operating system"
        exit 1
    fi


}

findLinuxDistributionAndInstall() {
    echo -e "Finding Type of Distribution..."

    currentDir=$(pwd)

    if grep -q 'debian' /etc/os-release; then
        echo -e "Distribution: Debian"

        # Debian does not have installed per default sudo package, so install first and then run sudo commands
        echo -e "Updating package lists and install sudo"
        apt-get update -y && apt-get install -y sudo

        $(sudo chmod +x $(pwd)/installers/debian.sh)
        $(echo  "${currentDir}/installers/debian.sh")
    elif grep -q 'arch' /etc/os-release; then
        echo -e "Distribution: Arch"
        $(echo  "${currentDir}/installers/arch.sh")
    else
        echo -e "Script not supported in this Linux GNU Distribution" #Error
    fi

    startInstallFreeradius
    moveConfigurationFile
}

startInstallFreeradius() {
    sudo apt-get install freeradius -y 
    echo -e "Cek Versi Freeradius..."
    freeradius -v
    
    echo -e "Konfigurasi Mysql Freeradius..."
    sudo apt-get install freeradius-mysql
    
    
}

moveConfigurationFile() {
    #Move MODS conf file to enable
    echo -e "Remove SQL configuration file..."
    sudo rm /etc/freeradius/3.0/mods-available/sql
    echo -e "Moving SQL configuration file..."
    sudo mv /nsnconfig/sql /etc/freeradius/3.0/mods-available/
    
    # symlink it
    sudo ln -s /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/sql
    
    # verif owner
    sudo chown -R freerad:freerad /etc/freeradius/3.0/mods-enabled/sql

    #Move SITES conf file to enable
    echo -e "Remove default configuration file..."
    sudo rm /etc/freeradius/3.0/sites-available/default
    sudo rm /etc/freeradius/3.0/sites-available/inner-tunnel
    echo -e "Moving default configuration file..."
    sudo mv /nsnconfig/default /etc/freeradius/3.0/sites-available/
    sudo mv /nsnconfig/inner-tunnel /etc/freeradius/3.0/sites-available/
    
    # restart and status
    echo -e "Start Freeradius"
    sudo systemctl restart freeradius
    sudo systemctl status freeradius

}


init
