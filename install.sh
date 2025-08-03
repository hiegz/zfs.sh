#!/bin/bash

. $PWD/common.sh

if [ ! -f "/etc/arch-release" ]; then
    echo "error: you must be running arch"
    echo "info:  quitting ..."
    exit 1
fi

if [ ! -d $ZFSDIR/.git ]; then
    echo "error: unable to find zfs repo clone"
    echo "hint:  run 'make fetch'"
    echo "info:  quitting ..."
    exit 1
fi

cd $ZFSDIR
git reset --hard $ZFSVERSION
sh autogen.sh
./configure
make -s -j$(nproc)
sudo make install
sudo ldconfig
sudo depmod
