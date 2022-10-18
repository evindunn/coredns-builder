FROM golang:bullseye as downloader

ARG RELEASE=v1.10.0
ARG ARCH=arm64

RUN apt-get update && \
    apt-get install -y git make

RUN git clone --single-branch --depth 1 -b ${RELEASE} https://github.com/coredns/coredns.git /coredns

WORKDIR /coredns

RUN make    

FROM docker:cli

ARG RELEASE=v1.10.0
ARG ARCH=arm64

ENV RELEASE=$RELEASE
ENV ARCH=$ARCH

COPY --from=downloader /coredns /coredns
COPY build.sh /build.sh

RUN mkdir /dist && chmod +x /build.sh
WORKDIR /dist

CMD ["/build.sh"]
