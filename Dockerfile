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
    procps && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY start.sh .

RUN chmod +x start.sh

CMD ["./start.sh"]
