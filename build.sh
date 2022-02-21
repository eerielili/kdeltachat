#!/bin/sh
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
make -C build
make -C build PREFIX=/usr install
