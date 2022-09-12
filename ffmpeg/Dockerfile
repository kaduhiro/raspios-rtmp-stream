ARG VERSION=3.16.2

FROM alpine:${VERSION}
LABEL maintainer="kaduhiro <kaduhiro@github.com>"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        tzdata \
        ffmpeg \
        v4l-utils

RUN rm -rf /var/cache/apk/*

ENTRYPOINT ["ffmpeg"]
