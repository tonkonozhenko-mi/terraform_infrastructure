#!/bin/bash
sudo apt -y update
sudo apt -y install mc
sudo apt -y install default-jdk
sudo apt -y install unzip
sudo apt -y install maven
sudo apt -y install npm
sudo npm -y install -g yarn
npm update -g @angular/cli
sudo mkdir teamcity
sudo chown -R ubuntu /var/ubuntu
sudo wget -O teamCity.tar.gz https://download.jetbrains.com/teamcity/TeamCity-2020.2.2.tar.gz?_ga=2.175301669.60879802.1613028860-1795692882.1612763354
sudo tar zxf teamCity.tar.gz -C /home/ubuntu/teamcity --strip-components 1

#Створюємо сервіс для автоматичного запуску TeamCity
sudo touch /etc/systemd/system/teamcity.service
sudo -su
sudo cat <<EOF >> /etc/systemd/system/teamcity.service
[Unit]
Description=TeamCity Build
After=network.target

[Service]

User=ubuntu
#Group=ubuntu

ExecStart=/home/ubuntu/teamcity/bin/runAll.sh start
ExecStop=/home/ubuntu/teamcity/bin/runAll.sh stop

RemainAfterExit=yes

SuccessExitStatus=0 143

[Install]
WantedBy=multi-user.target
EOF
exit
sudo chmod 744 /home/ubuntu/teamcity/bin/runAll.sh
sudo chmod 644 /etc/systemd/system/teamcity.service
sudo systemctl daemon-reload
sudo systemctl enable teamcity.service
sudo chown -R ubuntu /home/ubuntu/
sudo systemctl restart teamcity