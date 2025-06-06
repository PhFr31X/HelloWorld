FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
    curl \
    wget \
    git \
    nano \
    openssh-client \
    tmate \
    procps \
    iptables \
    kmod && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://tailscale.com/install.sh | sh

WORKDIR /root
COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]
