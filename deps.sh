#!/bin/bash

if [ ! -f "/etc/arch-release" ]; then
    echo "error: you must be running arch"
    echo "info:  quitting ..."
    exit 1
fi

sudo pacman -S --noconfirm --needed \
    base-devel \
    python
