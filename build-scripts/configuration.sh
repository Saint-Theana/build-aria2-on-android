#!/data/data/io.neoterm/files/usr/bin/bash

export ANDROID_HOME=/data/data/io.neoterm/files/home/Arm-Ndk-Toolchain-aarch64-android-26/


PREFIX=$ANDROID_HOME/usr/local
TOOLCHAIN=$ANDROID_HOME/toolchain
PATH=$TOOLCHAIN/bin:$PATH
HOST=aarch64-linux-android
./configure \
    --host=$HOST \
    --disable-nls \
    --without-gnutls \
    --with-openssl \
    --without-sqlite3 \
    --without-libxml2 \
    --with-libexpat \
    --with-libcares \
    --with-libz \
    --with-libssh2 \
    --with-sqlite3 \
    CC="$TOOLCHAIN"/bin/$HOST-clang \
    CXX="$TOOLCHAIN"/bin/$HOST-clang++ \
    CXXFLAGS="-Os -g" \
    CFLAGS="-Os -g" \
    CPPFLAGS="-fPIE" \
    LDFLAGS="-fPIE -pie -L$PREFIX/lib" \
    PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig" \
    --with-ca-bundle='/sdcard/ca-certificates.crt'

 
