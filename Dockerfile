ARG golang
ARG alpine



FROM ${golang} AS builder
RUN curl -sL https://taskfile.dev/install.sh | sh /dev/stdin v3.33.1
ADD . /go/src/github.com/telia-oss/github-pr-resource
WORKDIR /go/src/github.com/telia-oss/github-pr-resource
RUN ./bin/task build

FROM ${alpine} AS resource
RUN apk add --update --no-cache \
    git \
    git-lfs \
    openssh \
    git-crypt
COPY scripts/askpass.sh /usr/local/bin/askpass.sh
COPY --from=builder /go/src/github.com/telia-oss/github-pr-resource/build /opt/resource
RUN chmod +x /opt/resource/*

FROM resource
LABEL MAINTAINER=telia-oss
