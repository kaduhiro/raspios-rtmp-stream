ARG NGINX_VERSION=1.23.1
ARG NGINX_RTMP_MODULE_VERSION=1.2.2
ARG NGINX_PATH=/usr/local/nginx

FROM nginx:${NGINX_VERSION}-alpine AS builder

ARG NGINX_VERSION
ARG NGINX_RTMP_MODULE_VERSION
ARG NGINX_PATH

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        tzdata \
        alpine-sdk openssl-dev pcre-dev zlib-dev

RUN mkdir /usr/local/src
WORKDIR /usr/local/src

RUN curl -fsSL \
        -O https://github.com/nginx/nginx/archive/release-${NGINX_VERSION}.tar.gz \
        -O https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz
RUN find . -name '*.tar.gz' | xargs -n 1 tar xvf 
RUN cd nginx-release-${NGINX_VERSION} && \
    ./auto/configure \
        --prefix=${NGINX_PATH} \
        --with-http_ssl_module \
        --add-module=../nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
    make -j$(nproc) && \
    make install

COPY config/nginx.conf ${NGINX_PATH}/conf/nginx.conf
COPY config/conf.d ${NGINX_PATH}/conf.d

FROM nginx:${NGINX_VERSION}-alpine
LABEL maintainer="kaduhiro <kaduhiro@github.com>"

ARG NGINX_VERSION
ARG NGINX_PATH

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
       tzdata \
       pcre

COPY --from=builder ${NGINX_PATH} ${NGINX_PATH}

ENV PATH=${NGINX_PATH}/sbin:$PATH
WORKDIR ${NGINX_PATH}

RUN rm -rf /var/cache/apk/*

EXPOSE 80
EXPOSE 1935

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

