FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

COPY . /app
WORKDIR /app

ENTRYPOINT ["/bin/bash"] # Just for debugging

