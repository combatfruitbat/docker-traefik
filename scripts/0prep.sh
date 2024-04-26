sudo apt update
sudo apt upgrade -y
sudo apt install acl apache2-utils ca-certificates curl gnupg lsb-release ntp htop zip unzip gnupg apt-transport-https ca-certificates net-tools ncdu -y
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt update
sudo apt install crowdsec-firewall-bouncer-iptables -y
sudo curl -L https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

#Update UFW for CloudFlare. From From <https://designinterventionsystems.com/plone-blog/configuring-the-ufw-firewall-to-allow-cloudflare-ip-addresses> 
wget https://www.cloudflare.com/ips-v4 -O ips-v4-$$.tmp
wget https://www.cloudflare.com/ips-v6 -O ips-v6-$$.tmp
for cfip in `cat ips-v4-$$.tmp`; do echo "ufw allow from $cfip to any port 443 proto tcp"; done
for cfip in `cat ips-v6-$$.tmp`; do echo "ufw allow from $cfip to any port 443 proto tcp"; done

# Install certbot Certificates 
# From <https://certbot.eff.org/instructions?ws=other&os=ubuntufocal> 
sudo snap install --classic certbot
snap set certbot trust-plugin-with-root=ok
sudo snap install --classic certbot-dns-cloudflare
sudo certbot certonly --standalone

sudo systemctl enable docker

