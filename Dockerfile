FROM linuxserver/code-server:latest

RUN apt-get update && apt-get install -y  openjdk-17-jdk\
    openjdk-17-jre \