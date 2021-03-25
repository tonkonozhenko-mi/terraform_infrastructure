#!/bin/bash
sudo apt -y update
sudo apt -y install mc
sudo apt -y install apache2

# Створюємо конфігурацію load balancera щоб він міг перенаправляти запити між двома бекенд серверами
sudo cat <<EOF >> /etc/apache2/sites-enabled/000-default.conf
<VirtualHost *:8080>
<Location "/balancer-manager">
    SetHandler balancer-manager
</Location>
        
<Proxy "balancer://eschool">
        BalancerMember http://10.0.2.5:8080
        BalancerMember http://10.0.2.6:8080
</Proxy>

ProxyPass / balancer://eschool/
ProxyPassReverse / balancer://eschool

</VirtualHost>
EOF

# В конфігурації веб-сервера вказуємо його ім'я як глобальна адреса, замість localhost
sudo cat <<EOF >> /etc/apache2/apache2.conf
ServerName 3.143.71.85
EOF

# Змінюємо порт в конфігурації веб-серверу, на який в подальшому ми будемо звертатись.
sed -i 's/80/8080/' /etc/apache2/ports.conf

sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests
 
sudo systemctl restart apache2