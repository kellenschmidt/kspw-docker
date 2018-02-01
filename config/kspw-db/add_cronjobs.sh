#!/bin/bash

# Install cron
apt-get update -y && apt-get install -y cron nano

# Add environment variables to Cron's environment
printenv >> /etc/environment

# Add Cron commands to crontab
crontab /home/cron/db-backup.cron

# Start cron
cron
