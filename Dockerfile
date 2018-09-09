FROM alpine:latest

RUN deluser guest ; delgroup users
RUN addgroup -g 985 -S users
RUN adduser -S -G users -u 1000 -s /bin/sh -h /home/mudrii mudrii

# https://releases.hashicorp.com/packer/
ENV PACKER_VERSION=1.2.5
ENV PACKER_SHA256SUM=bc58aa3f3db380b76776e35f69662b49f3cf15cf80420fc81a15ce971430824c

RUN apk --no-cache update && \
    apk --no-cache add \
    ca-certificates \
    curl && \
    curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer_${PACKER_VERSION}_linux_amd64.zip && \
    echo "${PACKER_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > packer_${PACKER_VERSION}_SHA256SUMS && \
    sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin && \
    rm -f packer_${PACKER_VERSION}_linux_amd64.zip && \
    apk --purge del curl && \
    rm /var/cache/apk/*

USER mudrii
