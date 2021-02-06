if [ "$SQUEEZE" == "1" ]; then
      apt-get install -fy squeezelite
      cp -v /app/squeeze.conf /etc/default/squeezelite
      squeezelite -z
fi
