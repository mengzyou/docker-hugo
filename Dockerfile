# Base image
FROM alpine:3.10

ENV VERSION=0.55.6 \
    ARCH=Linux-64bit

RUN set -x \
    && cd /tmp/ \
    && wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz \
    && tar zxf hugo_${VERSION}_${ARCH}.tar.gz \
    && mv ./hugo /usr/local/bin/ \
    && rm -rf * \
    && wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_${ARCH}.tar.gz \
    && tar zxf hugo_extended_${VERSION}_${ARCH}.tar.gz \
    && mv ./hugo /usr/local/bin/hugo-ext \
    && rm -rf * \
    && adduser -h /app -D -u 1000 app

USER app

WORKDIR /app

EXPOSE 1313

CMD ["hugo","server"]
