#!/bin/bash

# Arguments
# $1: Comma (no spaces) seperated list of URLs to get HTTPS certificates for

wget https://dl.eff.org/certbot-auto -P /usr/bin
chmod a+x /usr/bin/certbot-auto
certbot-auto --non-interactive --agree-tos --email kellen@kellenschmidt.com --authenticator standalone --installer apache --domains $1
