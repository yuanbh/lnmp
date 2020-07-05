FROM khs1994/docker-image-sync

WORKDIR /root/lnmp/windows/

ARG DEST_DOCKER_REGISTRY
ARG DEST_DOCKER_USERNAME
ARG DEST_DOCKER_PASSWORD
ARG DEST_NAMESPACE
ARG CONFIG_URL=https://gitee.com/khs1994-docker/lnmp/raw/19.03/dockerfile/sync/docker-image-sync-by-docker.json

ENV DEST_DOCKER_REGISTRY $DEST_DOCKER_REGISTRY
ENV DEST_DOCKER_USERNAME $DEST_DOCKER_USERNAME
ENV DEST_DOCKER_PASSWORD $DEST_DOCKER_PASSWORD
ENV DEST_NAMESPACE $DEST_NAMESPACE
ENV CONFIG_URL $CONFIG_URL

RUN curl -L ${env:CONFIG_URL} -o docker-image-sync.json \
  ; ./docker-image-sync.ps1 \
  ; rm -rf /root/.khs1994-docker-lnmp

# --build-arg DEST_DOCKER_REGISTRY
# --build-arg DEST_DOCKER_USERNAME
# --build-arg DEST_DOCKER_PASSWORD
# --build-arg DEST_NAMESPACE
# --build-arg CONFIG_URL
