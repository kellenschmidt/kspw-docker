#!/bin/bash

# Arguments
# $1: Additional text to be added to output file name

date=$(date +"%d-%m-%Y_%H:%M:%S")
mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD --lock-tables=false --add-drop-database --add-drop-table --databases personal_website url_shortener_php | gzip > /home/db-backups/mysql-$1-backup_$date.sql.gz
