#!/bin/bash

# checking required packages
for PKG in  php5-dev libncurses5-dev php-pear libreadline-dev make; do
dpkg -s "$PKG" >/dev/null 2>&1 && {
    echo "$PKG already installed. Skipping..."
} || {
    echo "$PKG is not installed. Try to install..."
    apt-get -y install $PKG 
}
done;


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LUA_DOWNLOAD_URL=http://www.lua.org/ftp/
LUA_VERSION=5.2.1
LUA_GET_URL=${LUA_DOWNLOAD_URL}lua-${LUA_VERSION}.tar.gz
PHP_LUA_DOWNLOAD_URL=http://pecl.php.net/get/lua-1.0.0.tgz
PHP_VERSION=$(grep '#define PHP_API_VERSION' /usr/include/php5/main/php.h|sed 's/#define PHP_API_VERSION//' | sed 's/\s//');



echo "======= Getting lua and php lua source ======="
mkdir /tmp/phplua
cd /tmp/phplua

echo "======= Getting lua source from ${LUA_GET_URL} ======="
wget $LUA_GET_URL

echo "======= Getting php lua source ======="
wget $PHP_LUA_DOWNLOAD_URL

echo "======= Extracting source ======="
tar -xf lua-${LUA_VERSION}.tar.gz
tar -xf lua-1.0.0.tgz

echo "======= Building Lua ======="
cd /tmp/phplua/lua-${LUA_VERSION}
#patching makefile for compiling in 64 bit
echo "Adding -fPIC argument to compiler for building in 64bit system"
sed -i 's/CFLAGS= -O2/CFLAGS= -fPIC -O2/g' src/Makefile
make linux test
make linux install

echo "======= Building PHP Lua ======="
cd /tmp/phplua/lua-1.0.0
echo "Patching config for building in 64bit system"
patch -p1 ${SCRIPT_DIR}/config.m4 -i ${SCRIPT_DIR}/config_x64.path
cp ${SCRIPT_DIR}/config.m4 /tmp/phplua/lua-1.0.0/
phpize
./configure
# patching php-lua by adding include path for lua sources
sed -i "s/INCLUDES =/INCLUDES = -I\/tmp\/phplua\/lua-${LUA_VERSION}\/src/g" /tmp/phplua/lua-1.0.0/Makefile
make
make install

rm -r /tmp/phplua
