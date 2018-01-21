#!/bin/sh

# Download and install kellenschmidt.com code
if [ "$1" == "test" ]
then
	folder="test.kellenschmidt.com"
else
	folder="kellenschmidt.com"
fi

rm -rf $folder
git clone https://github.com/kellenschmidt/kellenschmidt.com.git $folder
cd $folder
if [ "$1" != "prod" ]; then
    git checkout -b ongoing-dev origin/ongoing-dev
fi
npm install
ng build --prod-aot=false --env=$1

# Download and install urlshortenerphp.kellenschmidt.com code
rm -rf urlshortenerphp.kellenschmidt.com
git clone https://github.com/kellenschmidt/urlshortenerphp.kellenschmidt.com.git
cd urlshortenerphp.kellenschmidt.com
