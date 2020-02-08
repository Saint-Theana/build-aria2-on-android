#!/bin/bash

# In this configuration, the following dependent libraries are compiled:
#
# * zlib
# * c-ares
# * expat
# * sqlite3
# * openSSL
# * libssh2

#CHECK TOOL FOR DOWNLOAD
 aria2c --help > /dev/null
 if [ "$?" -eq 0 ] ; then
   DOWNLOADER="aria2c --check-certificate=false"
 else
   DOWNLOADER="wget -c"
 fi
 
a(){
LD_LIBRARY_PATH=/data/data/io.neoterm/files/usr/lib bash $@
}

## DEPENDENCES ##
ZLIB=http://sourceforge.net/projects/libpng/files/zlib/1.2.11/zlib-1.2.11.tar.gz
OPENSSL=http://www.openssl.org/source/openssl-1.0.2o.tar.gz
EXPAT=https://sourceforge.net/projects/expat/files/expat/2.2.0/expat-2.2.0.tar.bz2
SQLITE3=http://www.sqlite.org/2018/sqlite-autoconf-3230100.tar.gz
C_ARES=http://c-ares.haxx.se/download/c-ares-1.14.0.tar.gz
SSH2=https://www.libssh2.org/download/libssh2-1.7.0.tar.gz

## CONFIG ##
ARCH="aarch64"
HOST="aarch64-linux-android"
PREFIX="/data/data/io.neoterm/files/home/opt/aria2-arm-android/build_libs"
LOCAL_DIR="/data/data/io.neoterm/files/home/opt/aria2-arm-android/build_libs"

TOOL_BIN_DIR="/data/data/io.neoterm/files/home/NDK/aarch64-linux-android-4.9/prebuilt/linux-arm64/bin"
PATH=${TOOL_BIN_DIR}:$PATH

DEST="/data/data/io.neoterm/files/home/opt/aria2-arm-android/build_libs"
CC=$HOST-gcc
CXX=$HOST-g++
LDFLAGS="-L$DEST/lib"
CPPFLAGS="-I$DEST/include"
CXXFLAGS=$CFLAGS
MAKE="make -j8"
CONFIGURE="./configure --prefix=${LOCAL_DIR} --host=$HOST"
BUILD_DIRECTORY=/data/data/io.neoterm/files/usr/tmp

## BUILD ##
cd $BUILD_DIRECTORY
#
 # zlib build
 $DOWNLOADER $ZLIB
  tar zxvf zlib-1.2.11.tar.gz
  cd zlib-1.2.11/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc STRIP=$HOST-strip RANLIB=$HOST-ranlib CXX=$HOST-g++ AR=$HOST-ar LD=$HOST-ld a ./configure --prefix=$PREFIX  --static
  $MAKE
  make install
#
 # expat build
  cd ..
  $DOWNLOADER $EXPAT
  tar jxvf expat-2.2.0.tar.bz2
  cd expat-2.2.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static=yes --enable-shared=no
  $MAKE
  make install
#
 # c-ares build
  cd ..
  $DOWNLOADER $C_ARES
  tar zxvf c-ares-1.14.0.tar.gz
  cd c-ares-1.14.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static --disable-shared
  $MAKE
  make install
#
 # Openssl build
  cd ..
  $DOWNLOADER $OPENSSL
  tar zxvf openssl-1.0.2o.tar.gz
  cd openssl-1.0.2o/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./Configure linux-armv4 $CFLAGS --prefix=$PREFIX shared zlib zlib-dynamic -D_GNU_SOURCE -D_BSD_SOURCE --with-zlib-lib=$LOCAL_DIR/lib --with-zlib-include=$LOCAL_DIR/include
  $MAKE CC=$CC
  make CC=$CC install_sw INSTALLTOP=$DEST OPENSSLDIR=$DEST/ssl
#
 # sqlite3
  cd ..
  $DOWNLOADER $SQLITE3
  tar zxvf sqlite-autoconf-3230100.tar.gz
  cd sqlite-autoconf-3230100/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --prefix=$PREFIX --enable-static --enable-shared --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE`
  $MAKE
  make install
#
 # libssh2
  cd ..
  $DOWNLOADER $SSH2
  tar zxvf libssh2-1.7.0.tar.gz
  cd libssh2-1.7.0/
  rm -rf $PREFIX/lib/pkgconfig/libssh2.pc
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ AR=$HOST-ar RANLIB=$HOST-ranlib ./configure --host=$HOST --without-libgcrypt --with-openssl --without-wincng --prefix=$PREFIX --enable-static --disable-shared
  $MAKE
  make install
#
 #cleaning
  cd ..
  rm -rf c-ares*
  rm -rf sqlite-autoconf*
  rm -rf zlib-*
  rm -rf expat-*
  rm -rf openssl-*
  rm -rf libssh2-*
#
 echo "finished!"
