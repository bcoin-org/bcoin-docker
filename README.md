Bcoin on Docker
=====

Start up a bcoin node quickly using Docker.
Pulls latest bcoin version from github and starts full node.

By default, persists data in user home directory at `~/.bcoin`.

Container based on AlpineLinux for speed and portability.

How To Use
----

Copy sample configuration to `secrets/bcoin.conf`:
>Important: Be sure to keep API secrets safe.
```
$ mkdir -p secrets
$ cp bcoin.example.conf secrets/bcoin.conf
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
