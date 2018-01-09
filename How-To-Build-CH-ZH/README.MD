手机环境必须root，否则没法用NDK的toolchain。或者有其他办法。

需要的软件:
1:  Neoterm(apt高级shell环境安装)
2:  文件管理器(re,推荐用mt)


1:安装好neoterm的环境(非系统shell)
安装以下软件:
apt install pkg-config perl tar libtool autoconf automake wget


然后打开文件管理器获取root权限

进入/data目录，新建文件夹命名为"NDK"，注意大小写，更改至最高权限0777。

将我提供的toolchain.tar.gz移动/复制到/data/NDK

打开Neoterm，输入su获取root权限。。然后执行如下命令:

cd /data/NDK
tar xvf toolchain.tar.gz
mkdir -p ./usr/local/lib/pkgconfig
chmod -R 777 /data/NDK

然后已经可以删掉toolchain.tar.gz了，已经用完了。

这时候就是安装依赖包。想办法把openssl,sqlite3,zlib,c-ares,zlip,libssh2,aria2-1.33.1等的tar.gz文件弄到Neoterm的home页面。比如:
1:把tar.gz文件(除toolchain.tar.gz不再需要了外的所有tar.gz文件，包括.bz2文件)放到/sdcard，然后在Neoterm里(如果是root状态，输入exit退出)输入cd 然后回车，这样就是在home页面了。输入指令 
mv /sdcard/*.tar.gz ./  
mv /sdcard/*.tar.bz2 ./
这样应该所有的tar.gz文件都会被移动到当前目录下。


然后就是编译依赖包了
顺序为zlib---->expat----->c-ares----->openssl----->sqlite3----->libssh2
其实我觉得应该只需要注意zlib --->  openssl ----> libssh2  这三个的顺序然后其他的应该没有太大关系。

编译依赖包的指令大概步骤:
打开neoterm，cd到home目录(每次刚打开Neoterm后的默认是该目录)
tar xvf 文件名.tar.gz
然后cd到该目录，比如编译zlib，就是 
cd zlib*
如果显示错误，就先执行ls，然后复制整个目录的名字比如:
cd zlib-1.2.11
然后就是configure，configure完了就直接make。
make install完了之后执行cd ..返回上级目录，继续编译下一个依赖库。
各个依赖包的configure和make代码如下:


编译全部依赖之前先执行一次
export ANDROID_HOME=/data/NDK
TOOL_BIN_DIR=$ANDROID_HOME/toolchain/bin
PATH=${TOOL_BIN_DIR}:$PATH

zlib的执行
PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc STRIP=/data/NDK/toolchain/bin/aarch64-linux-android-strip RANLIB=/data/NDK/toolchain/bin/aarch64-linux-android-ranlib CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ AR=/data/NDK/toolchain/bin/aarch64-linux-android-ar LD=/data/NDK/toolchain/bin/aarch64-linux-android-ld ./configure --prefix=/data/NDK/usr/local --static
make
make install

expat的
PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ ./configure --host=aarch64-linux-android --prefix=/data/NDK/usr/local --enable-static=yes --enable-shared=no
  make
  make install

c-ares的
PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ ./configure --host=aarch64-linux-android --prefix=/data/NDK/usr/local --enable-static --disable-shared

openssl的
PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ ./Configure linux-aarch64 -march=armv8-a -mtune=cortex-a53 --prefix=/data/NDK/usr/local shared zlib zlib-dynamic -D_GNU_SOURCE -D_BSD_SOURCE --with-zlib-lib=/data/NDK/usr/local/lib --with-zlib-include=/data/NDK/usr/local/include
  make
  make install_sw
                ↑
  注意，不是 install，是install_sw
  
  
sqlite3的
  PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ ./configure --host=aarch64-linux-android --prefix=/data/NDK/usr/local --enable-static --enable-shared
  make
  make install
  
  libssh2的
  chmod 700 ./configure
  PKG_CONFIG_PATH=/data/NDK/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=/data/NDK/usr/local/lib/:$LD_LIBRARY_PATH CC=/data/NDK/toolchain/bin/aarch64-linux-android-gcc CXX=/data/NDK/toolchain/bin/aarch64-linux-android-g++ AR=aarch64-linux-android-ar RANLIB=aarch64-linux-android-ranlib CPPFLAGS="-I/data/NDK/usr/local/usr/local/include" LDFLAGS="-L/data/NDK/usr/local/usr/local/lib" ./configure --prefix="/data/NDK/usr/local/usr/local/" --with-libssl-prefix=/data/NDK/usr/local/ --host=aarch64-linux-android
  make 
  make install
  

  
  
  
接下来就可以编译aria2了，
tar xvf aria2-1.33.1.tar.gz 
cd aria2-1.33.1
在这里有一件事需要说明，如果想在下载https链接时开启证书验证，必须在configure是加入ca证书路径。
比如--with-ca-bundle='/sdcard/ca-certificates.crt'
那么在后面你启动编译好的aria2c的时候，必须把ca-certificates.crt这个文件放到sdcard，不然无效。可设置成其他路径，这里看你的喜好。
在./android-config里边最后一行修改。
最大线程我自己改成了128了,想改的在 src/OpinionHandlerFactory.cc搜索128，然后修改

开始编译:
./android-config

./android-make 


/data/NDK/toolchain/bin/aarch64-linux-android-strip src/aria2c

cp src/aria2c ../

然后就可以拿出来用了，可以放在/data 或者其他目录，要可以改权限才行。不然没法执行。

比如放到/system/xbin
同样，lib链接库也要放到 /system/lib64 
lib文件在/data/NDK/usr/local/lib 需要的应该是如下:
libcrypto.so.1.1
libsqlite3.so
libssh2.so
libssl.so.1.1
然后用的时候直接执行aria2c就可以了
