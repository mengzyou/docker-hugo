# Base image
FROM alpine:3.16

ENV VERSION=0.111.3 \
    ARCH=linux-amd64

RUN apk add --no-cache tini \
    && adduser -D hugo \
    && mkdir -p /home/hugo/app \
    && chown -R hugo:hugo /home/hugo/app

# Install hugo binary
RUN set -x \
    && cd /tmp/ \
    && wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_${ARCH}.tar.gz \
    && tar zxf hugo_${VERSION}_${ARCH}.tar.gz \
    && mv ./hugo /usr/local/bin/ \
    && rm -rf *

WORKDIR /home/hugo/app
USER hugo
EXPOSE 1313

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "hugo", "server", "--bind=0.0.0.0"]
