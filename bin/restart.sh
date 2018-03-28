#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

cd ~/kspw-docker
bash bin/stop.sh
cd ~/
bash ~/init/prepare-for-delete.sh
rm -rf ~/kspw-docker

curl -L https://api.github.com/repos/kellenschmidt/kspw-docker/tarball/master > ~/kspw-docker.tar.gz
tar -xzf ~/kspw-docker.tar.gz
mv ~/kellenschmidt-kspw-docker-* ~/kspw-docker
rm ~/kspw-docker.tar.gz

bash ~/init/init-from-delete.sh
cd ~/kspw-docker
bash bin/start.sh $1
