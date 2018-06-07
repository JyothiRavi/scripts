#!/bin/bash
# Reset
Color_Off='\033[0m'       # Text Reset
# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

echo -e "$Cyan \n Select the following options for installing the specific package.$Color_Off"
while true; do
echo -e "$Yellow \n 1.Apache $Color_Off "
echo -e "$Yellow \n 2.Mysql $Color_Off "
echo -e "$Yellow \n 3.Php $Color_Off "
echo -e "$Yellow \n 4.Mongodb $Color_Off "
echo -e "$Yellow \n 5.Phpmyadmin $Color_Off "
echo -e "$Yellow \n 6.Nodejs and Npm $Color_Off "
echo -e "$Yellow \n 7.Git $Color_Off "
echo -e "$Yellow \n 8.Zip $Color_Off "
echo -e "$Yellow \n Enter your choice, or 0 for exit: $Color_Off "
read choice
case "$choice" in
     "1")
          echo -e "$Purple \n Checking the apache is installed or not. $Color_Off"
                            if [[ $(netstat -lnp | grep ':80') = *apache2* || $(which apache2) = *apache2* ]];
                            then
							a=$(apachectl -v)
                            echo -e "$Red \n Apache is already Installed and the version is ${a} . Do you want to remove ? . $Color_Off"
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing apache"
								 apt-get remove -y apache2*
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
                    else
                        echo -e "$Purple \n Apache is not installed now its going to install. $Color_Off"
                        sleep 5
                        apt-get update
                        apt-get install -y apache2 libapache2-mod-php \
                        &&  a2enmod ssl \
                        &&  a2enmod proxy \
                        &&  a2enmod rewrite \
                        &&  sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf \
                        &&  service apache2 restart \
                        &&  update-rc.d apache2 defaults
                                                # Adding some duplicate virtual host with proxy and without proxy.

                            echo -e "$Green \n Apache is Successfully Installed. $Color_Off"
                          fi;;

     "2")                               echo -e "$Purple \n Checking the mysql is installed or not. $Color_Off"
                        if [[ $(netstat -lnp | grep ':3306') = *mysql* || $(which mysql) = *mysql* ]];
                                then
                                a=$(mysql -V)
                                echo -e "$Red \n Mysql is already Installed and the version is ${a}. Do you want to remove ? . $Color_Off"
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing Mysql"
								 apt-get remove -y mysql-*
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
                        else
                                echo -e "$Purple \n Select the version which you want to install $Color_Off"
                                while true; do
                                echo -e "$Yellow \n 1.Mysql 5.6 $Color_Off "
                                echo -e "$Yellow \n 2.Mysql 7.0 $Color_Off "
								echo -e "$Yellow \n Enter your choice, or Press 0 for Main Menu "
                                read version
                                 case "$version" in
                        "1") add-apt-repository ppa:ondrej/mysql-5.6 \
                                                                && apt-get update \
                                                                && apt-get install -y mysql-server-5.6 \
                                                                && service mysql-server start \
                                                                && update-rc.d mysql defaults
                                                                a=$(mysql -V)
                                                                echo -e "$Green \n Mysql is Successfully Installed and the version is ${a} $Color_Off";;
                        "2") add-apt-repository ppa:ondrej/mysql-5.6 \
                                                                && apt-get update \
                                                                && apt-get install -y mysql-server-5.7 \
                                                                && service mysql-server start \
                                                                && update-rc.d mysql defaults
                                                                a=$(mysql -V)
                                                                echo -e "$Green \n Mysql is Successfully Installed and the version is ${a} $Color_Off";;
                        "0")
                              echo -e "$Green \n OK, You are now in Main Menu $Color_Off"

                                 break ;;
                         *)
                                echo -e "$Red \n That is not a valid choice, try a number from 0 to 2 $Color_Off";;
                        esac
                        done
                        fi;;

         "3")   echo -e "$Purple \n Checking the php is installed or not. $Color_Off"
                        if [[ $(which php) = *php* ]];
                                then
                                a=$(php -v)
                                echo -e "$Red \n Php is already Installed and the version is ${a}. Do you want to remove ? . $Color_Off"
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing Php"
								 apt-get remove -y php*
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
                        else
                                echo -e "$Purple \n Select the php version which you want to install $Color_Off"
                                                                while true; do
                                                                echo -e "$Yellow \n 1.Php 5.6 $Color_Off "
                                                                echo -e "$Yellow \n 2.Php 7.0 $Color_Off "
                                                                echo -e "$Yellow \n 3.Php 7.1 $Color_Off "
                                                                echo -e "$Yellow \n Enter your choice, or Press 0 for Main Menu "
                                                                read version
                                           case "$version" in

                        "1")
                                add-apt-repository ppa:ondrej/php \
                                && apt-get update \
                                && apt-get install -y php5.6 php5.6-gd php5.6-soap php5.6-xmlrpc php5.6-xml php5.6-mbstring php5.6-mcrypt php5.6-mongodb php5.6-mysql
                                service apache2 restart
                                a=$(php -v)
                                echo -e "$Green \n Php is Successfully Installed and the version is ${a}. $Color_Off"
                                ;;
                        "2")    add-apt-repository ppa:ondrej/php \
                                i&& apt-get update \
                                && apt-get install -y php7.0 php7.0-gd php7.0-soap php7.0-xmlrpc php7.0-xml php7.0-mbstring php7.0-mcrypt php7.0-mongodb php7.0-mysql
                                service apache2 restart
                                a=$(php -v)
                                echo -e "$Green \n Php is Successfully Installed and the version is ${a}. $Color_Off";;
                        "3")
                                 add-apt-repository ppa:ondrej/php \
                                && apt-get update \
                                && apt-get install -y php7.1 php7.1-gd php7.1-soap php7.1-xmlrpc php7.1-xml php7.1-mbstring php7.1-mcrypt php7.1-mongodb
                                service apache2 restart
                                a=$(php -v)
                                echo -e "$Green \n Php is Successfully Installed and the version is ${a}. $Color_Off";;
                        "0")
                                        echo -e "$Green \n OK, You are now in Main Menu $Color_Off"

                                 break ;;
                         *)
                                echo -e "$Red \n That is not a valid choice, try a number from 0 to 3 $Color_Off";;

                        esac
                        done

                        fi;;
                    "4")   echo -e "$Purple \n Checking the Mongodb is installed or not. $Color_Off"
                        if [[ $(which mongo) = *mongo* || $(which mongo) = *mongod* ]];
                                then
                                a=$(mongod --version)
                                echo -e "$Red \n Mongodb is already Installed and the version is ${a}. Do you want to remove ? . $Color_Off"
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing Mongodb"
								 apt-get remove -y mongodb-org*
								 rm /etc/apt/sources.list.d/mongodb-org-*
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
                        else
                                echo -e "$Purple \n Select the Mongodb version which you want to install $Color_Off"
                                                                while true; do
                                                                echo -e "$Yellow \n 1.Mongodb 3.6 $Color_Off "
                                                                echo -e "$Yellow \n 2.Mongodb 3.4 $Color_Off "
                                                                echo -e "$Yellow \n 3.Mongodb 3.2 $Color_Off "
                                                                echo -e "$Yellow \n Enter your choice, or Press 0 for Main Menu "
                                                                read version
                                           case "$version" in

                        "1")    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
                                && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list \
                                                                && apt-get update \
                                                                && apt-get install -y mongodb-org=3.6.5 mongodb-org-server=3.6.5 mongodb-org-shell=3.6.5 mongodb-org-mongos=3.6.5 mongodb-org-tools=3.6.5 \
                                                                && systemctl enable mongod
                                                                   systemctl start mongod

                                a=$(mongod --version)
                                echo -e "$Green \n Mongodb is Successfully Installed and the version is ${a}. $Color_Off"
                                ;;

                        "2")    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
                                && echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list \
                                                                && apt-get update \
                                && apt-get install -y mongodb-org \
                                && systemctl enable mongod
                                                                   systemctl start mongod

                                a=$(mongod --version)
                                echo -e "$Green \n Mongodb is Successfully Installed and the version is ${a}. $Color_Off";;
                        "3")
                                 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
                                                                && echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
                                && apt-get update \
                                && apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20 \
                                                                && systemctl enable mongod
                                                                   systemctl start mongod

                                a=$(php -v)
                                echo -e "$Green \n Php is Successfully Installed and the version is ${a}. $Color_Off";;
                        "0")
                                        echo -e "$Green \n OK, You are now in Main Menu $Color_Off"

                                 break ;;
                         *)
                                echo -e "$Red \n That is not a valid choice, try a number from 0 to 3 $Color_Off";;

                        esac
                        done

                        fi;;
                                    "5")
          echo -e "$Purple \n Checking the phpmyadmin is installed or not. $Color_Off"
                            if [[ $(find / -name phpmyadmin | grep "phpmyadmin") = *phpmyadmin* ]];
                            then
                            echo -e "$Red \n Phpmyadmin is already Installed. Do you want to remove ? . $Color_Off"
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing Phpmyadmin"
								 apt-get remove -y phpmyadmin
								 
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
                    else
                        echo -e "$Purple \n Phpmyadmin is not installed now its going to install. $Color_Off"

                        apt-get update
                        apt-get install -y phpmyadmin \
                        &&  service apache2 restart
                        echo -e "$Green \n Phpmyadmin is Successfully Installed. $Color_Off"
                          fi;;
        "6")   echo -e "$Purple \n Checking the Nodejs and Npm is installed or not. $Color_Off"
                        if [[ $(which nodejs) = *nodejs* || $(which node) = *node* ]];
                                then
                                a=$(nodejs -v)
                                b=$(npm -v)
                                echo -e "$Red \n Nodejs and Npm is already Installed and the Nodejs version is ${a} \n and Npm version is ${b}. Do you want to remove $Color_Off"
                        
							read -r -p "Are You Sure? [Y/n] ? " input

							case $input in 
							[yY][eE][sS]|[yY])
							
							echo "Removing Nodejs and npm "
								 apt-get remove -y nodejs
								 
								;;

							[nN][oO]|[nN])
							echo "No"
							exit
							;;

						*)
							echo "Invalid input..."
								;;
							esac
						else
                                echo -e "$Purple \n Select the Nodejs version which you want to install $Color_Off"
                                                                while true; do
                                                                echo -e "$Yellow \n 1.Nodejs 10.3 $Color_Off "
                                                                echo -e "$Yellow \n 2.Nodejs 8.11 $Color_Off "
                                                                echo -e "$Yellow \n Enter your choice, or Press 0 for Main Menu "
                                                                read version
                                           case "$version" in

                        "1")    apt-get install curl python-software-properties \
                                && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
                                                                && apt-get update \
                                                                && apt-get install -y nodejs

                                a=$(nodejs -v)
                                                                b=$(npm -v)
                                echo -e "$Green \n Nodejs and Npm is successfully Installed and the Nodejs version is ${a} \n and Npm version is ${b}. $Color_Off"
                                ;;

                        "2")    apt-get install curl python-software-properties \
                                                                && curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
                                && apt-get update \
                                && apt-get install -y nodejs

                                a=$(nodejs -v)
                                                                b=$(npm -v)
                                echo -e "$Green \n Nodejs and Npm is successfully Installed and the Nodejs version is ${a} \n and Npm version is ${b}. $Color_Off"
                                ;;

                        "0")
                                        echo -e "$Green \n OK, You are now in Main Menu $Color_Off"

                                 break ;;
                         *)
                                echo -e "$Red \n That is not a valid choice, try a number from 0 to 2 $Color_Off";;

                        esac
                        done

                        fi;;
        "7")
          echo -e "$Purple \n Checking the Git is installed or not. $Color_Off"
                            if [[ $(which git) = *git* ]];
                            then
                            echo -e "$Red \n Git is already Installed $Color_Off"
                    else
                        echo -e "$Purple \n Git is not installed now its going to install. $Color_Off"
                        apt-get update \
                        && apt-get install -y git 

                            echo -e "$Green \n Git is Successfully Installed. $Color_Off"
                          fi;;		
        "8")
          echo -e "$Purple \n Checking the zip is installed or not. $Color_Off"
                            if [[ $(which zip) = *zip* ]];
                            then
                            echo -e "$Red \n Zip is already Installed $Color_Off"
                    else
                        echo -e "$Purple \n Zip is not installed now its going to install. $Color_Off"
                        apt-get update \
                        && apt-get install -y zip 

                            echo -e "$Green \n Zip is Successfully Installed. $Color_Off"
                          fi;;						  

        "0")
     echo -e "$Green \n OK, see you! $Color_Off"
     break
         ;;
        *)
         echo -e "$Red \n That is not a valid choice, try a number from 0 to 8. $Color_Off"
      ;;
esac
done