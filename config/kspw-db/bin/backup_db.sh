#!/bin/bash

# Arguments
# $1: Time period type of backup

date=$(date +"%d-%m-%Y_%H:%M:%S")
mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD --lock-tables=false --add-drop-database --add-drop-table --databases personal_website url_shortener_php | gzip > /home/backups/mysql-${ENV}-$1_$date.sql.gz
