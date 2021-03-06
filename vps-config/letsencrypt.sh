#!/bin/sh

# Stop apache-proxy
#docker-compose stop apache-proxy

# Allow certbot to connect to port 443
iptables -I INPUT  1 -p tcp --dport 443 -j ACCEPT
iptables -I OUTPUT 1 -p tcp --sport 443 -j ACCEPT

# create certificates for wt6.ephec-ti.be and subdomains www, b2b
certbot certonly -n --agree-tos --standalone --email sysadmin@wt6.ephec-ti.be \
    -d wt6.ephec-ti.be \
    -d www.wt6.ephec-ti.be \
    -d b2b.wt6.ephec-ti.be \

# create certificates for mailwt6.ephec-ti.be
certbot certonly -n --agree-tos --standalone --email sysadmin@wt6.ephec-ti.be \
    -d mail.wt6.ephec-ti.be \

# create certificates for voip.wt6.ephec-ti.be
certbot certonly -n --agree-tos --standalone --email sysadmin@wt6.ephec-ti.be \
    -d voip.wt6.ephec-ti.be \

# Remove iptables rules created for certbot
iptables -D INPUT 1
iptables -D OUTPUT 1

# Restart apache-proxy
#docker-compose start apache-proxy
