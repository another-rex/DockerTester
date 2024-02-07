FROM debian:testing-slim AS builder

RUN mkdir /src
WORKDIR /src
COPY src/ src

# Install required packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y maven

RUN mvn package -f ./src/pom.xml
