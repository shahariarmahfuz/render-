#!/bin/bash
set -e

# ১. SSH সার্ভিস স্টার্ট
sudo /usr/sbin/sshd

# ২. Render Health Check বাইপাস করার জন্য একটি ডামি HTTP সার্ভার চালু করা
# Render ডিফল্টভাবে $PORT ভেরিয়েবল দেয়, না থাকলে 10000 ব্যবহার করবে
PORT=${PORT:-10000}
python3 -m http.server $PORT &

# ৩. Ngrok কনফিগার এবং TCP টানেল চালু করা
if [ -n "$NGROK_AUTHTOKEN" ]; then
  # ngrok এ অথেনটিকেশন অ্যাড করা
  ngrok config add-authtoken "${NGROK_AUTHTOKEN}"
  
  # পোর্ট 22 এর জন্য TCP টানেল ব্যাকগ্রাউন্ডে চালু করা
  ngrok tcp 22 --log=stdout &
fi

# কন্টেইনারটি সচল রাখার জন্য
tail -f /dev/null
