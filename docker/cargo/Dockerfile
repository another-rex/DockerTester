FROM debian:testing-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && \
    apt-get -y install \
    pkg-config \
    build-essential \
    curl

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

# Set Rustup toolchain as default 
RUN rustup default stable

RUN mkdir /src
WORKDIR /src

COPY example/ ./

RUN cargo build --release

# Execute the test script
ENTRYPOINT ["./target/release/example"]
