FROM golang:1.21.6 AS builder
ADD . /go/src/github.com/telia-oss/github-pr-resource
WORKDIR /go/src/github.com/telia-oss/github-pr-resource
RUN curl -sL https://taskfile.dev/install.sh | sh /dev/stdin v3.33.1
RUN ./bin/task build

FROM alpine:3.19.1 AS resource
COPY --from=builder /go/src/github.com/telia-oss/github-pr-resource/build /opt/resource
RUN apk add --update --no-cache \
    git \
    git-lfs \
    openssh \
    git-crypt \
    && chmod +x /opt/resource/*
COPY scripts/askpass.sh /usr/local/bin/askpass.sh

FROM resource
LABEL MAINTAINER=telia-oss
