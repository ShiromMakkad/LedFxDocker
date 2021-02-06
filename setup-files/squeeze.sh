if [ "$SQUEEZE" == "1" ]; then
      apt-get install -fy squeezelite
      cp -v /app/ledfx-config/ /etc/default/squeezelite
      /etc/init.d/squeezelite start
fi
