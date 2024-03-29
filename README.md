[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/optimize-images.svg)](https://hub.docker.com/r/varnav/optimize-images) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT/)

## What's this?

It's dockerized [optimize-images](https://github.com/victordomingos/optimize-images/)

Uses latest version of [mozjpeg](https://github.com/mozilla/mozjpeg) library systemwide. Pillow is compiled with libimagequant. This means more efficient and faster compression compared to native OS library.

## How to use

### Run interactively to optimize /home/john/Photos/vacation folder keeping quality at 85 and width no more than 4096px

```sh
docker run --rm -it -v /home/john/Photos/vacation:/data varnav/optimize-images -q 85 -mw 4096 --keep-exif /data
```

### Run as daemon, watching /opt/imagedir directory

```sh
docker run -d --name optimize-images -v "/opt/imagedir/:/data" --restart on-failure:10 --network none --security-opt no-new-privileges  varnav/optimize-images --watch-directory /data
```

### Build (optional)

```sh
git clone https://github.com/varnav/optimize-images-docker.git && cd optimize-images-docker
docker build . -t varnav/optimize-images
```

### See also

* [filmcompress](https://github.com/varnav/filmcompress) - bulk compress movie files
* [ExifDate2FS](https://github.com/varnav/ExifDate2FS) - organize photo library by date
* [jpegoptim](https://github.com/tjko/jpegoptim)

### Alternative

Try [Squoosh CLI](https://www.npmjs.com/package/@squoosh/cli):

```
npm i -g @squoosh/cli
find . -name "*.jpg" -exec bash -c 'file="{}"; squoosh-cli --mozjpeg auto "$file"' \;
```

Thanks to [Zachary](https://zachrussell.net/blog/bulk-optimize-images-with-squoosh-cli/)
