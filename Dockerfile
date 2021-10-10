FROM alpine:edge

LABEL maintainer="Hugo Ferreira"

RUN apk add --no-cache \
    ca-certificates

RUN apk update && \
    apk upgrade --no-cache --available && \
    sync && \
    apk add --no-cache unbound bash

RUN wget -S http://www.internic.net/domain/named.cache -O /root.hints

RUN ln -sf /dev/stdout /unbound.log

ADD --chown=unbound:unbound unbound.conf /

EXPOSE 53/udp

EXPOSE 53/tcp

ENTRYPOINT ["/usr/sbin/unbound", "-c", "/unbound.conf", "-vvvv", "-d" ]
