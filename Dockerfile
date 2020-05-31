FROM mhart/alpine-node:10
RUN apk update && apk add openjdk8 bash
RUN mkdir /app/
WORKDIR /app/
ADD fdt.jar /app
ADD copy /app/
ADD server /app/
ADD verify /app/

