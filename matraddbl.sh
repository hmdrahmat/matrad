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
    else
        echo -e "Script not supported in this Linux GNU Distribution" #Error
    fi

    startInstallFreeradius
    moveConfigurationFile
    enableSqlCounter
}

startInstallFreeradius() {
    sudo apt-get install freeradius -y 
    echo -e "Cek Versi Freeradius..."
    freeradius -v
    
    echo -e "Konfigurasi Mysql Freeradius..."
    sudo apt-get install freeradius-mysql -y

    echo -e "Install Mysql Server..."
    sudo apt-get install mysql-server -y

    echo -e "Konfig Mysql Server..."
    sudo mkdir -p /var/run/mysqlid
    chown mysql:mysql /var/run/mysqlid
    sudo mysqlid_safe --skip-grant-tables &
    sleep 5


    # Allow remote access to MySQL server
    sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    
    # Restart MySQL server to apply changes
    sudo systemctl restart mysql
    
    # Configure firewall to allow MySQL traffic
    sudo ufw allow mysql

    # Log in to MySQL as root
    mysql -u root <<MYSQL_SCRIPT
    CREATE DATABASE IF NOT EXISTS nsnradius;
    CREATE USER 'nsnradius'@'%' IDENTIFIED BY 'nsnRad##99!';
    ALTER USER 'nsnradius'@'%' IDENTIFIED WITH mysql_native_password
    BY 'nsnRad##99!'; 
    GRANT ALL PRIVILEGES ON nsnradius.* TO 'nsnradius'@'%';
    FLUSH PRIVILEGES;
MYSQL_SCRIPT

    echo "MySQL database 'nsnradius' created and user 'nsnradius' granted access."

    # Import schema from SQL file
    mysql -u root -p  nsnradius < nsnconfig/nsnradius_schema.sql
    
    echo "Schema imported into MySQL database 'nsnradius'."
    
}

moveConfigurationFile() {
    #Move MODS conf file to enable
    echo -e "Remove SQL configuration file..."
    sudo rm /etc/freeradius/3.0/mods-available/sql
    echo -e "Moving SQL configuration file..."
    sudo mv nsnconfig/sql /etc/freeradius/3.0/mods-available/
    
    # symlink it
    sudo ln -s /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/sql
    
    # verif owner
    sudo chown -R freerad:freerad /etc/freeradius/3.0/mods-enabled/sql

    #Move SITES conf file to enable
    echo -e "Remove default configuration file..."
    sudo rm /etc/freeradius/3.0/sites-available/default
    sudo rm /etc/freeradius/3.0/sites-available/inner-tunnel
    echo -e "Moving default configuration file..."
    sudo mv nsnconfig/default /etc/freeradius/3.0/sites-available/
    sudo mv nsnconfig/inner-tunnel /etc/freeradius/3.0/sites-available/
    
   

}

enableSqlCounter() {
    echo -e "Remove sqlcounter configuration file..."
    sudo rm  /etc/freeradius/3.0/mods-available/sqlcounter
    sudo mv nsnconfig/sqlcounter /etc/freeradius/3.0/mods-available/
    
    echo -e "add sqlcounter configuration file..."
    sudo mv nsnconfig/accessperiod.conf /etc/freeradius/3.0/mods-config/sql/counter/mysql/
    sudo mv nsnconfig/quotalimit.conf /etc/freeradius/3.0/mods-config/sql/counter/mysql/

    echo -e "Remove radius configuration file..."
    sudo rm  /etc/freeradius/3.0/radiusd.conf
    sudo mv nsnconfig/radiusd.conf /etc/freeradius/3.0/

     # restart and status
    echo -e "Start Freeradius"
    sudo systemctl restart freeradius
    sudo systemctl status freeradius
}


init
