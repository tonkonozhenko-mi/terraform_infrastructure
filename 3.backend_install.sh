#!/bin/bash
sudo apt -y update
sudo apt -y install openjdk-8-jdk-headless
sudo apt -y install maven
sudo apt -y install mc
touch eschool

sudo cat <<EOF >> /etc/systemd/system/eschool.service
[Unit]
Description=eSchool Java REST Service
[Service]
User=ubuntu
# The configuration file application.properties should be here:

#change this to your workspace
WorkingDirectory=/home/ubuntu

#path to executable. 
#executable is a bash script which calls jar file
ExecStart=/home/ubuntu/eschool

SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sudo cat <<EOF >> /home/ubuntu/eschool
#!/bin/bash
sudo /usr/bin/java -jar eschool.jar
EOF

sudo chown -R ubuntu eschool
sudo chmod +x eschool
sudo chown -R ubuntu /etc/systemd/system/eschool.service
sudo chmod 744 /etc/systemd/system/eschool.service
sudo systemctl daemon-reload
sudo systemctl enable eschool