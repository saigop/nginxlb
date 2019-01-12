#!/bin/bash

echo 'Starting Provision: lb1'
sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx stop
sudo rm -rf /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-enabled/default
echo "upstream nodecluster {
        server 192.168.1.11;
        server 192.168.1.12;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                proxy_pass http://nodecluster;
        }

}" >> /etc/nginx/sites-enabled/default
sudo service nginx start
echo "Host: lb1" >> /usr/share/nginx/html/index.html
echo 'Provision lb1 complete'
