FROM httpd:2.4.43-alpine

LABEL maintainer="khs1994-docker/lnmp <khs1994@khs1994.com>"

ARG ALPINE_URL=dl-cdn.alpinelinux.org

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_URL}/g" /etc/apk/repositories \
    && echo 0
