FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV COLORTERM=truecolor

# Tailscale এবং প্রয়োজনীয় প্যাকেজ ইন্সটল
RUN apt-get update && apt-get install -y \
    curl wget git nano python3 \
    && curl -fsSL https://tailscale.com/install.sh | sh \
    && rm -rf /var/lib/apt/lists/*

# ইউজার তৈরি
RUN useradd -m -s /bin/bash -u 1000 devuser

COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /home/devuser

# কন্টেইনার রুট হিসেবেই চলবে, তাই sudo দরকার নেই
CMD ["/start.sh"]
