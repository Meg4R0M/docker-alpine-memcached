FROM alpine:3.7

LABEL memcached.version=1.5.3
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="memcached-alpine" \
    org.label-schema.description="small Memcached image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-memcached-alpine"

ARG DOCKER_TIMEZONE=Europe/Paris

# Configure timezone
# -----------------------------------------------------------------------------
RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/$DOCKER_TIMEZONE /etc/localtime && \
    echo $DOCKER_TIMEZONE > /etc/timezone

ENV MEMCACHED_USER=nobody

# Base packages
# -----------------------------------------------------------------------------
RUN apk --no-cache --update add memcached

#RUN rm /etc/memcached.conf
COPY memcached.conf /etc/memcached.conf

RUN chmod 644 /etc/memcached.conf

COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

# -----------------------------------------------------------------------------
# Clear archives in cache folder
RUN rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

EXPOSE 11211

# Run as memcached.
USER memcached

CMD ["/bootstrap.sh"]