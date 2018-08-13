FROM node:alpine AS base

RUN mkdir /code
WORKDIR /code
CMD "bcoin"

ENV BCOIN_VERSION=${BCOIN_VERSION} \
    BCOIN_REPO=https://github.com/bcoin-org/bcoin.git

RUN apk upgrade --no-cache && \
    apk add --no-cache bash git

RUN git clone $BCOIN_REPO /code && \
    git checkout $BCOIN_VERSION

FROM base AS build

# Install build dependencies
RUN apk add --no-cache g++ gcc make python2
RUN npm install --production

# Copy built files, but don't include build deps
FROM base
ENV PATH="${PATH}:/code/bin:/code/node_modules/.bin"
COPY --from=build /code /code/

# Main-net and Test-net
EXPOSE 8334 8333 8332 18334 18333 18332
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "bcoin-cli info >/dev/null" ]
