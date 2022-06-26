#!/bin/bash

python_version=$1

yum install -y \
    gcc \
    make \
    bzip2-devel \
    ncurses-devel \
    sqlite-devel \
    gdbm-devel \
    xz-devel \
    tk-devel \
    readline-devel \
    openssl \
    openssl-devel \
    hdf5-devel \
    libffi-devel

curl -O https://mirrors.huaweicloud.com/python/$python_version/Python-$python_version.tar.xz
tar -xvf Python-$python_version.tar.xz;cd Python-$python_version
./configure --prefix=/usr/bin/openssl --prefix=/usr/local/python$python_version
make;make install
ln -s /usr/local/python$python_version/bin/python3 /usr/local/bin/python3
