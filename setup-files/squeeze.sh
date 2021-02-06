if [ "$SQUEEZE" == "1" ]; then
      apt-get install -fy squeezelite
      cp -v /app/ledfx-config/ /etc/default/squeezelite
      squeezelite -z
fi
