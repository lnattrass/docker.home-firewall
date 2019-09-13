FROM alpine:latest

ADD tree/ /
ADD keys/ /root/.abuild/

RUN apk update \
    && apk add alpine-sdk \
    && abuild-keygen -n -a -i \
    && adduser root abuild

WORKDIR /usr/src/nftables

RUN abuild -F -r