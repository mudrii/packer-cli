FROM alpine:latest

RUN deluser guest ; delgroup users
RUN addgroup -g 985 -S users
RUN adduser -S -G users -u 1000 -s /bin/sh -h /home/mudrii mudrii

# https://releases.hashicorp.com/packer/
ENV PACKER_VERSION=1.3.1
ENV PACKER_SHA256SUM=254cf648a638f7ebd37dc1b334abe940da30b30ac3465b6e0a9ad59829932fa3

RUN apk --no-cache update && \
    apk --no-cache add \
    ca-certificates \
    curl && \
    curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer_${PACKER_VERSION}_linux_amd64.zip && \
    echo "${PACKER_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > packer_${PACKER_VERSION}_SHA256SUMS && \
    sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin && \
    rm -f packer_${PACKER_VERSION}_linux_amd64.zip && \
    apk --purge del curl

USER mudrii
