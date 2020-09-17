FROM alpine:edge

LABEL maintainer="Hugo Ferreira"

RUN apk update && \
    apk upgrade --available && \
    sync && \
    apk add unbound bash && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

RUN wget -S https://www.internic.net/domain/named.cache -O /root.hints

RUN ln -sf /dev/stdout /unbound.log

ADD --chown=unbound:unbound unbound.conf /

EXPOSE 53/udp

EXPOSE 53/tcp

ENTRYPOINT ["/usr/sbin/unbound", "-c", "/unbound.conf", "-vvvv", "-d" ]
