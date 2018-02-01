#!/bin/bash

date=$(date +"%d-%m-%Y_%H:%M:%S")
mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD --lock-tables=false --add-drop-database --add-drop-table --databases personal_website url_shortener_php | gzip > /home/db-backups/mysql-backup_$date.sql.gz
