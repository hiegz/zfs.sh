#!/bin/bash

. $PWD/common.sh

if [ ! -f "/etc/arch-release" ]; then
    echo "error: you must be running arch"
    echo "info:  quitting ..."
    exit 1
fi

sudo pacman -S --noconfirm --needed \
    base-devel \
    python

test -d $ZFSDIR/.git || git clone --single-branch --branch $ZFSVERSION --depth 1 https://github.com/openzfs/zfs $ZFSDIR
cd $ZFSDIR
git fetch origin $ZFSVERSION
git reset --hard $ZFSVERSION
sh autogen.sh
./configure
make -s -j$(nproc)
sudo make install
sudo ldconfig
sudo depmod
