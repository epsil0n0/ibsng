#!/bin/bash

service httpd start
service postgresql start
service IBSng start

chown  -R apache:apache /var/www/html
chown  -R postgres:postgres /var/lib/pgsql

# The container will run as long as the script is running, that's why
# we need something long-lived here
exec tail -f /var/log/IBSng/ibs_error.log
