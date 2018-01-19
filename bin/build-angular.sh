#!/bin/sh

git clone https://github.com/kellenschmidt/kellenschmidt.com.git
cd kellenschmidt.com
npm install
ng build --prod-aot=false