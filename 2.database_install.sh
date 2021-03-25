#!/bin/bash
sudo apt -y update
sudo apt -y install mc
sudo apt -y install mariadb-server
#sudo mysql_secure_installation


# Створюємо базу даних і користувача з правами адміністратора
sudo mysql <<EOF
CREATE DATABASE eschool CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON eschool.* TO 'theadmin'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
EOF

# Робимо зміни в файлі конфігурації бази даних що б вона могла "слухати" всіх
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo systemctl restart mariadb