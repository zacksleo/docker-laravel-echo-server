FROM node:10-alpine

WORKDIR /app

### Install Laravel Echo Server and dependencies
RUN apk add --update --no-cache git openssl \
 && apk add --update --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
 && yarn global add --prod --no-lockfile  https://github.com/zacksleo/laravel-echo-server.git#4d44d4fde30cb341d10f79086678da38be1447fe \
 && apk del .build-deps \
 && yarn cache clean \
 && mkdir -p /app/database

COPY . /usr/local/

ENTRYPOINT ["docker-entrypoint"]

VOLUME /app

EXPOSE 6001

HEALTHCHECK --interval=30s --timeout=5s \
        CMD /usr/local/bin/health-check

CMD ["start"]
