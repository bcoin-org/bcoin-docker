FROM alpine:3.5
MAINTAINER Steven Bower <steven@purse.io>

# Cache buster
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid

ENV BCOIN_BRANCH=master \
    BCOIN_REPO=https://github.com/bcoin-org/bcoin.git

RUN apk --no-cache add bash build-base git make nodejs python unrar \
    && mkdir -p /code/node_modules/bcoin /data \
    && git clone --branch $BCOIN_BRANCH $BCOIN_REPO /code/node_modules/bcoin \
    && cd /code/node_modules/bcoin \
    && npm install --production \
    && npm uninstall node-gyp \
    && apk del build-base make python unrar

CMD ["node", "/code/node_modules/bcoin/bin/node"]
