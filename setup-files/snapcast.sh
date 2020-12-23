#!/bin/bash

cd /app

if [[ $(dpkg --print-architecture) ==  "armhf" ]] || [[ $(dpkg --print-architecture) == "arm64" ]]; then
    wget https://github.com/badaix/snapcast/releases/download/v0.22.0/snapclient_0.22.0-1_armhf.deb
    dpkg -i snapclient_0.22.0-1_armhf.deb
else
    wget https://github.com/badaix/snapcast/releases/download/v0.22.0/snapclient_0.22.0-1_amd64.deb
    dpkg -i snapclient_0.22.0-1_amd64.deb
fi

apt-get -fy install
snapclient --host "$HOST" --daemon 1