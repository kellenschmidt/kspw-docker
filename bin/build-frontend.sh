#!/bin/sh

rm -rf kellenschmidt.com
git clone https://github.com/kellenschmidt/kellenschmidt.com.git
cd kellenschmidt.com
git checkout -b ongoing-dev origin/ongoing-dev
npm install
ng build --prod-aot=false --env=docker