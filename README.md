# Born2beroot


# Summary: 

This document is a System Administration related exercise

# Object :

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox (or UTM if you can’t use VirtualBox)
under specific instructions. Then, at the end of this project, you will be able to set up
your own operating system while implementing strict rules.

# VM installations :

Install (Without Graphic user interface)

Choose language

Territory or area: -depending on your localisations

Hostname: yamzil42

Domain name: left it blank

Setup root passwd user's login and passwd

# SSH 

brief explications :

 SSH, for Secure Shell, refers to both a communication protocol and a computer program. It allows the connection of a remote machine (server) via a secure link in order to transfer files or commands securely. 

installing ssh :

$ sudo apt-get update
$ sudo apt install openssh-server

Check the SSH server status :

$ sudo systemctl status ssh

Restart the SSH service :

$ service ssh restart

Changing default port (22) to 4242 :

sudo vi etc/ssh/sshd_config
sudo vi etc/ssh/ssh_config

# UFW (Uncomplicated Firewall)

brief explications :

UFW is a new simplified command line configuration tool from Netfilter, which provides an alternative to the iptables tool. UFW should eventually allow automatic configuration of the firewall when installing programs that need it.

Enable :

$ sudo ufw enable

Check the status :

$ Check the status (numbered)

Configure the port rules

$ sudo ufw allow ...

# SUDO

Login as root

$ su -

Install sudo

$ apt-get update -y
$ apt-get upgrade -y
$ apt install sudo

# Passworld Policy

Installing password quality checking library (libpam-pwquality):

$ sudo apt-get install libpam-pwquality

# MONITORING SCRIPT :

Check monitoring.sh

crontab file who contains rules for cron daemon. This is a task scheduler ("run this command at this time on this date"). This way we can run automatically our monitoring script.

Install cron :

$ apt-get cron

Edit cron in order to run script as root :

sudo crontab -u root -e

To write in the crontab file, schedule the script for every 10 minutes :

*/10 * * * * sh /path/monitoring.sh

# Bonus Part :

Installing Lighttpd :

$ sudo apt install lighttpd 

Allow incoming connections :

$ sudo ufw allow 80

Installing & Configuring MariaDB :

$ sudo apt install mariadb-server

Start interactive script to remove insecure default settings :

$ sudo mysql_secure_installation
Enter current password for root (enter for none): #Just press Enter
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y

Log in to the MariaDB console :

$ sudo mariadb
MariaDB [(none)]>

Create new database :

*MariaDB [(none)]> CREATE DATABASE <database-name>;
  
Create new database user and grant them full privileges :

*MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username>'@'localhost' IDENTIFIED BY '<password>' WITH GRANT OPTION;
  
*Flush the privileges :

*MariaDB [(none)]> FLUSH PRIVILEGES;
 
Exit the MariaDB :

*MariaDB [(none)]> exit
  
Verify whether database user was successfully created :

*$ mariadb -u <username> -p
Enter password: <password>

*MariaDB [(none)]>

Confirm whether database :
  
*MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
Exit the MariaDB :

*MariaDB [(none)]> exit;
  
# Installing PHP
  
Install php-cgi & php-mysql :
 
*$ sudo apt install php-cgi php-mysql
  
Downloading & Configuring WordPress :
  
Install wget :

$ sudo apt install wget
  
Download WordPress to /var/www/html :
  
$ sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
    
Extract downloaded content :

$ sudo tar -xzvf /var/www/html/latest.tar.gz

Remove tarball :

$ sudo rm /var/www/html/latest.tar.gz

Copy content of /var/www/html/wordpress to /var/www/html :

$ sudo cp -r /var/www/html/wordpress/* /var/www/html

Remove /var/www/html/wordpress :

$ sudo rm -rf /var/www/html/wordpress

Create WordPress configuration file from its sample :

$ sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  
Configure WordPress to reference previously-created MariaDB database & user :

$ sudo vi /var/www/html/wp-config.php

Replace the below

* 23 define( 'DB_NAME', 'database_name_here' );
* 26 define( 'DB_USER', 'username_here' );
* 29 define( 'DB_PASSWORD', 'password_here' );
with:
* 23 define( 'DB_NAME', '<database-name>' );
* 26 define( 'DB_USER', '<username>' );
* 29 define( 'DB_PASSWORD', '<password>' );

# Configuring Lighttpd
  
Enable below modules :

* $ sudo lighty-enable-mod fastcgi;
* $ sudo lighty-enable-mod fastcgi-php;
* $ sudo service lighttpd force-reload
