sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y
sudo cat <<EOF >> /etc/nginx/sites-available/vproapp
upstream vproapp {
server app01:8080;
}
server {
listen 80;
location / {
proxy_pass http://vproapp;
}
}
EOF
sudo rm -rf /etc/nginx/sites-enabled/default

sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
sudo systemctl restart nginx