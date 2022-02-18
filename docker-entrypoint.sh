#!/bin/bash

usermod -d /var/lib/mysql mysql
service mysql start
mysql < /usr/src/docker-mysql-init.sql


php -S 0.0.0.0:80