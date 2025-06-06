FROM ubuntu:22.04  # or debian:bullseye-slim

RUN apt update && \
    apt install -y --no-install-recommends \
    tmate \
    curl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]
