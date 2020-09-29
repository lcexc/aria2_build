#!=/bin/bash

export HOST=i686-w64-mingw32

mkdir deps && cd deps
curl -L -O https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
curl -L -O https://github.com/libexpat/libexpat/releases/download/R_2_2_7/expat-2.2.7.tar.bz2
curl -L -O https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
curl -L -O http://zlib.net/zlib-1.2.11.tar.gz
curl -L -O https://c-ares.haxx.se/download/c-ares-1.15.0.tar.gz
curl -L -O https://www.libssh2.org/download/libssh2-1.9.0.tar.gz

tar xf gmp-6.1.2.tar.lz && \
    cd gmp-6.1.2 && \
    ./configure \
        --disable-shared \
        --enable-static \
        --prefix=/usr/local/$HOST \
        --host=$HOST \
        --disable-cxx \
        --enable-fat \
        CFLAGS="-mtune=generic -O2 -g0" && \
    make install

tar xf expat-2.2.7.tar.bz2 && \
    cd expat-2.2.7 && \
    ./configure \
        --disable-shared \
        --enable-static \
        --prefix=/usr/local/$HOST \
        --host=$HOST \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` && \
    make install

tar xf sqlite-autoconf-3290000.tar.gz && \
    cd sqlite-autoconf-3290000 && \
    ./configure \
        --disable-shared \
        --enable-static \
        --prefix=/usr/local/$HOST \
        --host=$HOST \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` && \
    make install

tar xf zlib-1.2.11.tar.gz && \
    cd zlib-1.2.11 && \
    CC=$HOST-gcc \
    AR=$HOST-ar \
    LD=$HOST-ld \
    RANLIB=$HOST-ranlib \
    STRIP=$HOST-strip \
    ./configure \
        --prefix=/usr/local/$HOST \
        --libdir=/usr/local/$HOST/lib \
        --includedir=/usr/local/$HOST/include \
        --static && \
    make install

tar xf c-ares-1.15.0.tar.gz && \
    cd c-ares-1.15.0 && \
    ./configure \
        --disable-shared \
        --enable-static \
        --without-random \
        --prefix=/usr/local/$HOST \
        --host=$HOST \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
        LIBS="-lws2_32" && \
    make install

tar xf libssh2-1.9.0.tar.gz && \
    cd libssh2-1.9.0 && \
    ./configure \
        --disable-shared \
        --enable-static \
        --prefix=/usr/local/$HOST \
        --host=$HOST \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
        --without-openssl \
        --with-wincng \
        LIBS="-lws2_32" && \
    make install


