ARG golang
ARG alpine



FROM ${golang} AS builder

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y -qq update \
    && apt-get -y -qq install "make"

ADD . /go/src/github.com/telia-oss/github-pr-resource
WORKDIR /go/src/github.com/telia-oss/github-pr-resource

RUN go version \
    && make all



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
LABEL MAINTAINER=cloudfoundry-community
