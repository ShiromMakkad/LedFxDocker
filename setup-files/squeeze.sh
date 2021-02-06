if [ "$SQUEEZE" == "1" ]; then
    mv -vn /app/squeeze.conf /app/ledfx-config/
    apt-get install -fy squeezelite
    cp -v /app/ledfx-config/squeeze.conf /etc/default/squeezelite
    /etc/init.d/squeezelite start
fi
