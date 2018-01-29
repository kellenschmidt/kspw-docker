#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

sh bin/install-frontend.sh $1
sh bin/install-backend.sh $1
sh bin/install-phpurlshortener.sh