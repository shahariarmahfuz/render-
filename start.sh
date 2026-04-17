#!/bin/bash
set -e

# Render Health Check বাইপাস করার জন্য ডামি সার্ভার
PORT=${PORT:-10000}
python3 -m http.server $PORT &

# Tailscale ডেমন চালু করা
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

# Tailscale কানেক্ট করা এবং Tailscale SSH চালু করা
if [ -n "$TAILSCALE_AUTHKEY" ]; then
  tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname=render-box --ssh
fi

tail -f /dev/null
