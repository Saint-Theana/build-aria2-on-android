#!/data/data/io.neoterm/files/usr/bin/bash

apt install git -y

apt install make -y

cd

git clone git://github.com/Saint-Theana/Arm-Ndk-Toolchain-aarch64-android-26.git

export ANDROID_HOME=/data/data/io.neoterm/files/home/Arm-Ndk-Toolchain-aarch64-android-26/

mkdir -p Arm-Ndk-Toolchain-aarch64-android-26/usr/local/lib/pkgconfig

ZLIB=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/zlib1.2.11.tar.gz
EXPAT=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/expat-2.2.0.tar.bz2
CARES=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/c-ares1.13.0.tar.gz
OPENSSL=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/openssl-1.1.0g.tar.gz
SQLITE3=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/sqlite-3.21.0.tar.gz
LIBSSH2=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/libssh2-1.8.1_dev.tar.gz
ARIA2=https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/aria2-1.33.1.tar.gz


apt install wget tar pkg-config -y

cd 
wget $ZLIB
tar xvf zlib1.2.11.tar.gz
cd zlib*1
SHELL=/data/data/io.neoterm/files/usr/bin/bash PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc STRIP=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-strip RANLIB=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-ranlib CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ AR=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-ar LD=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-ld ./configure --prefix=$ANDROID_HOME/usr/local --static
make 
make install

cd 
wget $EXPAT
tar jxvf expat-2.2.0.tar.bz2
cd expat*0
SHELL=/data/data/io.neoterm/files/usr/bin/bash PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ AR=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-ar ./configure --host=aarch64-linux-android --prefix=$ANDROID_HOME/usr/local --enable-static=yes --enable-shared=no
  make
  make install

cd
wget $CARES
tar xvf c-ares1.13.0.tar.gz
cd c-ares*0
SHELL=/data/data/io.neoterm/files/usr/bin/bash PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ ./configure --host=aarch64-linux-android --prefix=$ANDROID_HOME/usr/local --enable-static --disable-shared
make
make install

cd 
wget $OPENSSL
tar xvf openssl-1.1.0g.tar.gz
cd openssl*g
SHELL=/data/data/io.neoterm/files/usr/bin/bash PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ ./Configure linux-aarch64 -march=armv8-a -mtune=cortex-a53 --prefix=$ANDROID_HOME/usr/local shared zlib zlib-dynamic -D_GNU_SOURCE -D_BSD_SOURCE --with-zlib-lib=$ANDROID_HOME/usr/local/lib --with-zlib-include=$ANDROID_HOME/usr/local/include
make
make install_sw

cd
wget $SQLITE3
tar xvf sqlite-3.21.0.tar.gz
cd sqlite*0
SHELL=/data/data/io.neoterm/files/usr/bin/bash PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ ./configure --host=aarch64-linux-android --prefix=$ANDROID_HOME/usr/local --enable-static --enable-shared
  make
  make install



cd 
wget $LIBSSH2
tar zxvf libssh2-1.8.1_dev.tar.gz
  cd libssh2
  apt install libtool autoconf automake -y
  chmod 700 ./buildconf
  ./buildconf
  PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/:$LD_LIBRARY_PATH CC=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-gcc CXX=$ANDROID_HOME/toolchain/bin/aarch64-linux-android-g++ AR=aarch64-linux-android-ar RANLIB=aarch64-linux-android-ranlib CPPFLAGS="-I$ANDROID_HOME/usr/local/usr/local/include" LDFLAGS="-L$ANDROID_HOME/usr/local/usr/local/lib" ./configure --prefix="$ANDROID_HOME/usr/local/usr/local/" --with-libssl-prefix=$ANDROID_HOME/usr/local/ --host=aarch64-linux-android
  make 
  make install
  
  
  cd 
  rm -rf c-ares*
  rm -rf sqlite*
  rm -rf zlib*
  rm -rf expat-*
  rm -rf openssl-*
  rm -rf libssh2*
  
  
 
  
