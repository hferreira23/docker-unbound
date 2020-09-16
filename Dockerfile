FROM alpine:edge

LABEL maintainer="Hugo Ferreira"

USER unbound:unbound

RUN apk update && \
    apk upgrade --available && \
    sync && \
    apk add unbound bash

RUN wget -S -N https://www.internic.net/domain/named.cache -O /var/lib/unbound/root.hints

ADD --chown=unbound:unbound unbound.conf /

EXPOSE ["53/udp", "53/tcp"]

VOLUME "/unbound.conf"

ENTRYPOINT ["/usr/sbin/unbound", "-c", "/unbound.conf", "-vvvv", "-d" ]
