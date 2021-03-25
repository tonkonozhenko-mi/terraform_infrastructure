#!/bin/bash
sudo apt -y update
sudo apt -y install mc
sudo apt -y install unzip
sudo apt -y install default-jdk
sudo apt -y install maven
sudo apt -y install npm
sudo npm -y install -g yarn
npm update -g @angular/cli
sudo chown -R ubuntu /home/

#Створюємо сервіс для автоматичного запуску TeamCity 
sudo touch /etc/systemd/system/teamcity_agent.service
sudo -su
sudo cat <<EOF >> /etc/systemd/system/teamcity_agent.service
[Unit]
Description=TeamCity Build
After=network.target

[Service]

User=ubuntu
#Group=ubuntu

ExecStart=/home/ubuntu/TeamCity_agent/bin/agent.sh start
ExecStop=/home/ubuntu/TeamCity_agent/bin/agent.sh stop

RemainAfterExit=yes

SuccessExitStatus=0 143

[Install]
WantedBy=multi-user.target
EOF
exit

sudo chown -R ubuntu /home/ubuntu/TeamCity_agent # Даємо права користувачу ubuntu на директорії
sudo chmod 644 /etc/systemd/system/teamcity_agent.service
sudo systemctl daemon-reload
sudo systemctl enable teamcity_agent.service
sudo chown -R ubuntu /home/ubuntu/
sudo systemctl restart teamcity_agent