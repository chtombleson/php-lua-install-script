PHP Lua Install Script
================================

For Ubuntu Linux 32 bit:
-------------------------
Requirements:
* Lib Readline Dev
* PHP Development files

How to use:

```bash
 ~/php-lua-install-script/$ sudo install.sh
```

Tested on ubuntu

For Ubuntu Linux 64 bit:
-------------------------

*(added by @nolka)*

All dependencies automatically downloaded and installed durning install.

For now(in Ubuntu Server 13.04) is:
* php5-dev
* php-pear
* libreadline-dev
* libncurses-dev
* make

How to use:
```bash
 $ cd /tmp
 $ git clone https://github.com/chtombleson/php-lua-install-script.git 
 $ cd php-lua-install-script
 $ sudo ./install_x64.sh
```

Tested on a freshly installed Ubuntu Server 13.04 64 bit.