# TundraSoft - Transmission Docker

Transmission is an open source, lightweight BitTorrent client.

# Usage

You can run the docker image by

## docker run

```
docker run \
 --name=transmission \
 -e PUID=1000 \
 -e PGID=1000 \
 -e TZ=Europe/London \
 -e TRANSMISSION_WEB_HOME=/combustion-release/ \
 -e USER=username \
 -e PASS=password \
 -p 9091:9091 \
 -p 51413:51413 \
 -p 51413:51413/udp \
 --restart unless-stopped \
 tundrasoft/transmission-docker:latest
```

## docker Create

```
docker create \
  --name=transmission \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e TRANSMISSION_WEB_HOME=/combustion-release/ \
  -e USER=username \
  -e PASS=password \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v <path to data>:/config \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  tundrasoft/transmission-docker:latest
```

## docker-compose

```
version: "3.2"
services:
  transmission:
    image: tundrasoft/transmission-docker:latest
    ports:
      - 9091:9091 # WebUI
      - 51413:51413 # Torrent Port TCP
      - 51413:51413/udp # Torrent Port UDP
    environment:
      - PUID=1000 # for UserID
      - PGID=1000 # for GroupID
      - TZ=Asia/Kolkata # Specify a timezone to use EG Europe/London
      - TRANSMISSION_WEB_HOME=/combustion-release/ # Specify an alternative UI options are /combustion-release/, /transmission-web-control/, and /kettu/
      # - USERNAME=username # Specify an optional username for the interface
      # - PASSWORD=password # Specify an optional password for the interface
    volumes:
      - <path to config>:/config # Where transmission should store config files and logs.
      - <path to download>:/downloads # Local path for downloads (complete, incomplete and watch are sub folders)
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
```

## Ports

### 9091

The web UI port you can access the web ui @ this port, example - http://localhost:9091/ or http://<IP ADDRESS>:9091/

### 51413 (TCP & UDP)

Port used for torrent communication

## Variables

### PUID

The User ID to use to run the process as. This is primarily to ensure permission matches between the remote system and container (defaults to 1000)

### PGID

The Group ID to use to run the process as. This is primarily to ensure permission matches between the remote system and container (defaults to 1000)

### TZ

The timezone to use.

### USERNAME

To secure Transmission web ui with credential. This may not be the most secure mechanism and certainly not "production" ready, but close enough.
Set the Username to use for logging in.

#### NOTE - Password also needs to be set for authentication to work

### PASSWORD

Password to be used to loggin into transmission web ui

### TRANSMISSION_WEB_HOME

Customize the web ui with pre-installed themes. Refer Themes section

## Themes

Below themes are pre-installed for your benifit:

- Combustion Release (combusion-release)
- Kettu (kettu)
- Transmission Web Control (transmission-web-control)

To use a theme, set the value for environment variable to one of the above. If left blank the default theme will take over
