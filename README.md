## What's this?

It's dockerized [optimize-images](https://github.com/victordomingos/optimize-images/)

Uses [mozjpeg](https://github.com/mozilla/mozjpeg) library systemwide. This means more efficient and faster compression compared to native OS library.

You can revert to standard system library by `libjpeg` tag.

## How to use

### Run interactively to optimize /home/john/Photos/vacation folder keeping quality at 85

```sh
docker run --rm -it -v /home/john/Photos/vacation:/data varnav/optimize-images -q 85 --keep-exif /data
```

### Run as daemon, watching /opt/imagedir directory

```sh
docker run -d --name optimize-images -v /opt/imagedir/:/data --restart on-failure:10 --network none --security-opt no-new-privileges  varnav/optimize-images --watch-directory /data
```

### Build (optional)

```sh
git clone https://github.com/varnav/optimize-images.git && cd optimize-images
docker build mozjpeg -t varnav/optimize-images -t varnav/optimize-images:mozjpeg
docker build libjpeg -t varnav/optimize-images:libjpeg
```