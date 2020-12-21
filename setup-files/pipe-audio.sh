#!/bin/bash

# https://superuser.com/questions/1539634/pulseaudio-daemon-wont-start-inside-docker
rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse
pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit

rm /app/audio/stream
mkfifo -m a+rw /app/audio/stream
while true; do cat /app/audio/stream | aplay $FORMAT; done &