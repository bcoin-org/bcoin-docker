FROM alpine:edge
MAINTAINER Steven Bower <steven@purse.io>

# Build deps
RUN apk update && \
    apk upgrade
RUN apk add nodejs bash unrar git build-base make

ENV BCOIN_BRANCH master
ENV BCOIN_REPO https://github.com/bcoin-org/bcoin.git

RUN mkdir -p /code/node_modules/bcoin /data
RUN git clone --branch $BCOIN_BRANCH $BCOIN_REPO /code/node_modules/bcoin

# Installation
WORKDIR /code/node_modules/bcoin
RUN npm install --production

# Cleanup
RUN npm uninstall node-gyp
RUN apk del unrar build-base make && \
    rm /var/cache/apk/*

CMD ["node", "/code/node_modules/bcoin/bin/node"]
