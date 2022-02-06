#!/bin/sh

# for the qml.qrc
cp -r usr/share/knotifications5 .

cmake -B build .
cmake --build build
cp -v -r usr/  /
sudo install -vDm755 build/kdeltachat -t /usr/local/bin/
