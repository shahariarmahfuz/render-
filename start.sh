#!/bin/bash
set -e

# sudo ছাড়াই SSH সার্ভিস স্টার্ট
/usr/sbin/sshd

# Render Health Check এর জন্য ডামি HTTP সার্ভার
PORT=${PORT:-10000}
python3 -m http.server $PORT &

# Ngrok চালু করা
if [ -n "$NGROK_AUTHTOKEN" ]; then
  ngrok config add-authtoken "${NGROK_AUTHTOKEN}"
  ngrok tcp 22 --log=stdout &
fi

tail -f /dev/null
