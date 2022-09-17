# RTMP Streaming for Raspberry Pi OS

## Environment

* Model
  * Raspberry Pi 3 Model B
* Video
  * Logicool C270
* Audio
  * Logicool C270
* OS
  * [Raspberry Pi OS Lite](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2022-04-07/)
  * 64bit

## Usage

```
usage: make <target>

services:
  nginx
  ffmpeg

targets:
  build/<service>   build or rebuild a image
  run/<service>     run a one-off command on a container
  exec/<service>    run a command in a running container
  up                create and start containers, networks, and volumes
  up/<service>      create and start a container
  down              stop and remove containers, networks, images, and volumes
  down/<service>    stop and remove a container
  help              list available targets and some
  clean             remove cache files from the working directory
```
