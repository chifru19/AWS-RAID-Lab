# Use the latest Ubuntu image as our base
FROM ubuntu:latest

# Install mdadm for RAID and kmod for kernel modules
RUN apt-get update && apt-get install -y \
    mdadm \
    util-linux \
    kmod \
    && rm -rf /var/lib/apt/lists/*

# Keep the container running so we can interact with it
CMD ["sleep", "infinity"]