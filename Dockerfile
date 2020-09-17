FROM alpine:edge

LABEL maintainer="Hugo Ferreira"

RUN apk update && \
    apk upgrade --available && \
    sync && \
    apk add unbound bash

RUN wget -S https://www.internic.net/domain/named.cache -O /root.hints

RUN ln -sf /dev/stdout /unbound.log

ADD --chown=unbound:unbound unbound.conf /

EXPOSE 53/udp

EXPOSE 53/tcp

ENTRYPOINT ["/usr/sbin/unbound", "-c", "/unbound.conf", "-vvvv", "-d" ]
