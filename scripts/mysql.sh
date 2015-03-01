#!/usr/local/bin/bash
sudo pkg install -y mariadb55-server mariadb55-client >/dev/null
sudo bash -c "echo 'mysql_enable=YES' >> /etc/rc.conf"
sudo service mysql-server start
mysql_secure_installation
echo "mysql installed:"
mysql --version