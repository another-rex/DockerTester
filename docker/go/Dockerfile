# Dockerfile

# Use the debian:testing-slim base image
FROM debian:testing-slim AS go-base

RUN mkdir /src
WORKDIR /src

COPY base/ ./base

# Install required packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    golang \
    git

# Build the Go application
RUN cd ./base && go build -o main .

FROM go-base AS final
RUN mkdir ./final
COPY final/ ./final
RUN cd ./final && go build -o main .

# Command to run the executable
ENTRYPOINT ["./final/main"]