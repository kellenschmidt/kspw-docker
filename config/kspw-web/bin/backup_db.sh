#!/bin/bash

mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD --lock-tables=false --add-drop-database --add-drop-table --databases personal_website url_shortener_php
