#!/bin/bash
sudo yum install epel-release -y
sudo yum install memcached -y
systemctl start memcached
systemctl enable memcached
systemctl status memcached
sudo memcached -p 11211 -U 11111 -u memcached -d