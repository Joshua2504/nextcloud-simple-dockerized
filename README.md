# Simple dockerized Nextcloud
## ready for everything

This instance includes a cronjob and is ready to be used with all kind of apps.

You can add missing libraries via ``Dockerfile``.

## Setup

Copy ``.env.example`` to ``.env`` and modify it accordingly:

```
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_PASSWORD=password
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud
```

Then

```
docker compose up -d
```

Basic commands

```
docker compose up
docker compose up -d
docker compose down
docker compose restart
docker compose down && docker compose up -d
docker logs nextcloud --follow
```

By default Nextcloud will listen to port ``22012``.

You can change this beheavior by editing the ``docker-compose.yml``:

```
    ports:
      - "22012:80"
```
