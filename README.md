# Hugo Container Image

This repo is ued to build [hugo](https://github.com/gohugoio/hugo) container image, which can be used to build your hugo siatic web site.  

## Version

- [0.160.0, 0.16, latest](https://github.com/gohugoio/hugo/releases/tag/v0.106.0)  

## Usage

- Server in local

```shell
cd <your hugo project dir>
docker container run --rm -t -p 1313:1313 -v $(pwd):/home/hugo/app mengzyou/hugo
```

Browser to `http://localhost:1313/` .  

- BUild public static files  

```Dockerfile
FROM mengzyou/hugo AS builder

COPY . /home/hugo/app

RUN hugo

FROM mengzyou/easyhttpd

COPY --from=builder --chown=http:www /app/public/ /srv/www
```

```shell
docker build -t hugosite .

docker container run --rm -d -p 8008:8008 hugosite
```

Browser to `http://localhost:8008/` .