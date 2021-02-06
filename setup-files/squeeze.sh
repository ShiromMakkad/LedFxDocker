if [ "$SQUEEZE" == "1" ]; then
      apt-get install -fy squeezelite
      squeezelite -z
fi
