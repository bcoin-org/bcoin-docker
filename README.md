Bcoin on Docker
=====

Start up a bcoin node quickly using Docker.
Pulls latest bcoin version from github and starts full node.

By default, persists data in user home directory at `~/.bcoin`.

How To Use
----

Copy sample configurations to `secrets/` directory:
>Important: Be sure to keep API secrets safe.
```
$ mkdir -p secrets
$ cp bcoin.example.conf secrets/bcoin.conf
$ cp wallet.example.conf secrets/wallet.conf
```

Create `bcoin` network:
```
$ docker network create bcoin
```

Create `nginx-proxy` network:
```
$ docker network create nginx-proxy
```

Quick run, node only:
```
$ docker-compose up -d bcoin
```

Update to latest bcoin version:
```
$ docker-compose build --pull bcoin
```

HTTPS
----
Includes optional nginx wrapper for https. Add domain certs to `secrets/certs/`.

Update docker-compose `VIRUAL_HOST` domain setting.

See https://github.com/jwilder/nginx-proxy for more options.

# Wallet HTTP
Note that Wallet and Node API servers are on separate ports.
With the default `docker-compose.yml` configuration, Wallet API is accessible via `bcoin.yourdomain.org:8334/wallet`, while node endpoints are accessed through default HTTP/HTTPS ports.

Provided is a simple example of an nginx proxy to allow wallet API to be accessible
on a separate domain, in order to make it unnecessary to specify wallet port.

See `docker-compose.wallet.yml`. (Not required to actually use wallet API)

# Building

By default, docker-compose will use image pulled from `purse/bcoin:latest`, but you can build
one yourself.

There are two Dockerfiles available: `slim` and `arch`, currently `slim` will be used for latest by default.
Latest is hard coded into Makefile and will need updates overtime, but you can manually pass VERSION variable
and override current version.

## Examples
Build v1.0.0-beta.15 on slim:
  - `make` - Same as build
  - `make build` - Currently hard coded latest.
  - `make latest` - this will tag image as latest.
  - `VERSION=v1.0.0-beta.15 make build`

Build v1.0.0-beta.14 on arch: `VERSION=v1.0.0-beta.14 make arch`.  
Build v1.0.0-beta.15 on slim with different docker repository:
  `DOCKER_REPO=nchkuaselidze/bcoin VERSION=v1.0.0-beta.15 make`
