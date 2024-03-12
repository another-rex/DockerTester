# Base Image
FROM debian:bullseye

# Update packages and install system dependencies
RUN apt update && apt install -y python3 python3-pip

# Create a working directory
WORKDIR /app

# Install packages
RUN apt install -y \
    python3-django \ 
    php-phpseclib \
    squid \
    php-cas \
    node-ip

# Add lockfile
COPY ./python-test/requirements.txt /app/

# Expose the port Django usually runs on (optional)
EXPOSE 8000

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]
