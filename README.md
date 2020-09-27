**Unbound Docker Container**

A Docker container running unbound. 

The provided unbound.conf is a generic one which should setup a Caching DNS Resolver.

A custom config can be passed to the container with -v (or volume definition on Docker Compose)

Compose example:

```yaml
version: "3.8"
services:
  unbound:
    image: hferreira23/unbound
    container_name: unbound
    networks:
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    volumes:
      - ./unbound.conf:/unbound.conf
    restart: unless-stopped
```
