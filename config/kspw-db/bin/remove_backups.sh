#!/bin/bash

# Arguments
# $1: Backup type to be removed

# Remove all backups except newest 3
ls -t /home/db-backups/mysql-$1-backup_*.sql.gz | tail -n +3 | xargs rm -f --