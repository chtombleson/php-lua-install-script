SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LUA_DOWNLOAD_URL=http://www.lua.org/ftp/
LUA_VERSION=5.2.1
LUA_GET_URL=${LUA_DOWNLOAD_URL}lua-${LUA_VERSION}.tar.gz
PHP_LUA_DOWNLOAD_URL=http://pecl.php.net/get/lua-2.0.2.tgz
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
tar -xf lua-2.0.2.tgz

echo "======= Building Lua ======="
cd /tmp/phplua/lua-${LUA_VERSION}
make linux test
make linux install

echo "======= Building PHP Lua ======="
cd /tmp/phplua/lua-2.0.2
cp ${SCRIPT_DIR}/config.m4 /tmp/phplua/lua-2.0.2/
phpize
./configure
make
make install

rm -r /tmp/phplua
