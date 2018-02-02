#!/bin/bash

# Install cron
apt-get update -y && apt-get install -y cron nano

# Add environment variables to Cron's environment
printenv >> /etc/environment

# Combine individual cron files into single cron file
cat /home/cron/backup-db.cron > /home/cron/combined.cron
cat /home/cron/remove-backups.cron >> /home/cron/combined.cron

# Add Cron commands to crontab
crontab /home/cron/combined.cron

# Start cron
cron
