#!/bin/sh
cmake -B build .
cmake --build build
sudo install -vDm644 usr/* -t /
sudo install -vDm755 build/kdeltachat -t /usr/local/bin/
