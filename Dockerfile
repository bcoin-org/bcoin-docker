FROM nfnty/arch-mini:latest
MAINTAINER Steven Bower <steven@purse.io>

# Build deps
RUN pacman -Syu --noconfirm nodejs npm unrar git python2 base-devel

ENV BCOIN_BRANCH master
ENV BCOIN_REPO https://github.com/bcoin-org/bcoin.git

RUN mkdir -p /code/node_modules/bcoin /data && \
    git clone --branch $BCOIN_BRANCH $BCOIN_REPO /code/node_modules/bcoin

# Installation
WORKDIR /code/node_modules/bcoin
RUN npm install --production && \
# Cleanup
    npm uninstall node-gyp
    pacman -Rns --noconfirm unrar python2 && \
                rm /var/cache/pacman/pkg/*

CMD ["node", "/code/node_modules/bcoin/bin/node"]
