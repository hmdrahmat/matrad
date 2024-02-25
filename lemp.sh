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
}

startInstallFreeradius() {
    sudo apt-get install freeradius -y 
    echo -e "Cek Versi Freeradius..."
    freeradius -v
    
    echo -e "Konfigurasi Freeradius..."
    
    
}

moveConfigurationFile() {
    #Move nginx conf file to enable php support on ngnix
    echo -e "Moving Nginx configuration file..."
    sudo mv default /etc/nginx/sites-available/

    # Remove default config in sites-enabled if exists and symlink it
    sudo rm /etc/nginx/sites-enabled/default
    sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
    sudo nginx -t
    sudo systemctl reload nginx

    #Move php testing file
    echo -e "Moving php testing file..."
    sudo mv info.php /var/www/html/
}

startServices() {
    echo -e "Start Nginx"
    sudo service nginx start

    echo -e "Start PHP7.4-fpm"
    sudo service php7.4-fpm start

    echo -e "Lemp stack installed successfully :)"
    echo -e "Open following link to check installed PHP configuration your_ip/info.php"
    #!/bin/bash

    # Membuat kunci SSH baru tanpa email
    # ssh-keygen -t rsa -b 4096
    
    # Menampilkan kunci SSH
    # echo -e "Berikut adalah kunci SSH Anda:"
    # cat ~/.ssh/id_rsa.pub

    # Mengclone web
    cd /var/www/html
    echo -e "Sedang menjalankan perintah"
    git clone https://github.com/hmdrahmat/bolaweb2024.git

}

init
