#!/bin/bash

# https://superuser.com/questions/1539634/pulseaudio-daemon-wont-start-inside-docker
# Start the pulseaudio server
rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse
pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit

if [[ -v FORMAT ]]; then
    ./pipe-audio.sh
fi

if [[ -v HOST ]]; then
    ./snapcast.sh
fi

if [[ -v SQUEEZE ]]; then
    ./squeeze.sh
fi

mkdir /app/ledfx-config

mv -vn /app/config.yaml /app/ledfx-config/
mkdir /root/.ledfx
ledfx -c /app/ledfx-config 
