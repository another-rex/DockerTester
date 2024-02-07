FROM debian:testing-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    npm --no-install-recommends

RUN mkdir /src
WORKDIR /src

COPY src/ src

RUN cd src && npm ci

# Execute the test script
ENTRYPOINT ["node", "./src/test.js"]
