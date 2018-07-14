FROM alpine:latest

# Helm version https://releases.hashicorp.com/packer/

ENV PACKER_VERSION=1.2.4
ENV PACKER_SHA256SUM=258d1baa23498932baede9b40f2eca4ac363b86b32487b36f48f5102630e9fbb

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