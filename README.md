Bcoin on Docker
=====

Start up a bcoin node quickly using Docker.
Pulls latest bcoin version from github and starts full node.

By default, persists data in user home directory at `~/.bcoin`.

Container based on AlpineLinux for speed and portability.

How To Use
----

Copy sample configuration to `secrets/bcoin.conf`.

Important: Be sure to keep API secrets safe.

Quick run, node only:
`docker-compose up -d bcoin`

Update to latest bcoin & alpine version:
`docker-compose build bcoin --no-cache --pull`

HTTPS
----
Includes optional nginx wrapper for https. Add domain certs to `secrets/certs/`.

Update docker-compose `VIRUAL_HOST` domain setting.

See https://github.com/jwilder/nginx-proxy for more options.
