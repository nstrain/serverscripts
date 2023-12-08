#! /bin/bash
echo $1 $2

if [ -z ${1+x} ]; then exit 5; fi
if [ -z ${2+x} ]; then domain="com" ; else domain=$2; fi
echo $1.$domain

sudo mkdir /var/www/$1
sudo chown -R $USER:$USER /var/www/$1
sudo echo "<html><head> <title>Welcome to Your_domain!</title></head><body><h1>Success!  The $1 virtual host is working!</h1></body></html>" > /var/www/$1/index.html
echo -e "<VirtualHost *:80>\n    ServerAdmin webmaster@localhost\n    ServerName $1.$domain\n    ServerAlias www.$1.$domain\n    DocumentRoot /var/www/$1\n    ErrorLog \${APACHE_LOG_DIR}/error.log\n    CustomLog \${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" | sudo tee /etc/apache2/sites-available/$1.conf
sudo a2ensite $1.conf
sudo apache2ctl configtest

ln -s /var/www/$1 ~/www/$1
