#!/bin/bash
sudo yum update -y
sudo yum install epel-release -y

sudo yum install java-1.8.0-openjdk -y
yum install git maven wget -y
TOMURL="https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz"

cd /tmp/
wget $TOMURL 
tar xzvf apache-tomcat-8.5.37.tar.gz
sudo useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat
sudo cp -r /tmp/apache-tomcat-8.5.37/* /usr/local/tomcat8/
sudo chown -R tomcat.tomcat /usr/local/tomcat8

sudo rm -rf /etc/systemd/system/tomcat.service
sudo cat <<EOF >> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]

User=tomcat
Group=tomcat

WorkingDirectory=/usr/local/tomcat8

#Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre

Environment=CATALINA_PID=/var/tomcat/%i/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat8
Environment=CATALINE_BASE=/usr/local/tomcat8

ExecStart=/usr/local/tomcat8/bin/catalina.sh run
ExecStop=/usr/local/tomcat8/bin/shutdown.sh


RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

EOF
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

git clone -b local-setup https://github.com/achroo-82/vprofile-project.git
cd vprofile-project
mvn install
sudo systemctl stop tomcat
sleep 60
sudo rm -rf /usr/local/tomcat8/webapps/ROOT*
sudo cp target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war
sudo systemctl start tomcat
sleep 120
sudo cp /vagrant/application.properties /usr/local/tomcat8/webapps/ROOT/WEB-INF/classes/application.properties
systemctl restart tomcat
