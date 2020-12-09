[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/optimize-images.svg)](https://hub.docker.com/r/varnav/optimize-images) [![](https://images.microbadger.com/badges/image/varnav/optimize-images.svg)](https://microbadger.com/images/varnav/optimize-images "Image details") [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT/)

## What's this?

It's dockerized [optimize-images](https://github.com/victordomingos/optimize-images/)

Uses latest version of [mozjpeg](https://github.com/mozilla/mozjpeg) library systemwide. Pillow is compiled with libimagequant. This means more efficient and faster compression compared to native OS library.

You can revert to standard system library by `libjpeg` tag.

## How to use

### Run interactively to optimize /home/john/Photos/vacation folder keeping quality at 85

```sh
docker run --rm -it -v /home/john/Photos/vacation:/data varnav/optimize-images -q 85 --keep-exif /data
```

### Run as daemon, watching /opt/imagedir directory

```sh
docker run -d --name optimize-images -v "/opt/imagedir/:/data" --restart on-failure:10 --network none --security-opt no-new-privileges  varnav/optimize-images --watch-directory /data
```

### About experimental variant

* Will skip image replacement if gain is less than 5%
* Will be compiled optimized for your CPU, forcing AVX2 instructions. For this reason, you need to build it first, see below.

### Build (optional)

```sh
git clone https://github.com/varnav/optimize-images.git && cd optimize-images
docker build mozjpeg -t varnav/optimize-images -t varnav/optimize-images:mozjpeg
docker build libjpeg -t varnav/optimize-images:libjpeg
docker build experimental -t varnav/optimize-images:experimental
```
