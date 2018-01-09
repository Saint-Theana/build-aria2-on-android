Only Neoterm can be used on this Project.

Do not try other Terminal.

Aria2 depens on zlib,c-ares,expat,sqlite3,openssl,libssh2.
That means you need to build dependency libraries.Use build-libraries.sh to build them.

After finishing in building libraries.


download aria2 source code from:
https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/aria2-1.33.1.tar.gz

Do not use official source file,you will fail in that case.

```shell
wget https://raw.githubusercontent.com/Saint-Theana/build-aria2-on-android/master/Files/aria2-1.33.1.tar.gz
tar xvf aria2-1.33.1.tar.gz
cd aria2-1.33.1
```

Last thing you should note:
While downloading a HTTPS_URL Aria2c will check certificate from host,it will fail if aria2c couldn't get local ca-certificate.crt
One way is to use --check-certificate=false to turn down check certificate.like:
```shell
aria2c --check-certificate=false https://.......
```

