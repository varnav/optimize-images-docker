FROM python:3

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Python optimize-images in Docker"
LABEL License="MIT License"

ARG DEBIAN_FRONTEND=noninteractive

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000

RUN set -ex \
&& groupadd --gid "$HOST_USER_GID" user \
&& useradd --uid "$HOST_USER_UID" --gid "$HOST_USER_GID" --create-home --shell /bin/bash user \
&& pip install pillow optimize-images watchdog

### Code below will replace standard OS JPEG library with mozjpeg
### https://blog.avirtualhome.com/replace-jpeg-libraries-with-mozjpeg/

RUN set -ex \
&& apt-get update \
&& apt-get --no-install-recommends -y install build-essential cmake libtool autoconf automake m4 nasm pkg-config \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& ldconfig /usr/lib \
&& wget https://github.com/mozilla/mozjpeg/archive/v4.0.0.tar.gz \
&& tar xf v4.0.0.tar.gz \
&& cd mozjpeg-4.0.0 \
&& mkdir build \
&& cd build \
&& cmake -G"Unix Makefiles" .. \
&& make install libdir=/usr/lib/x86_64-linux-gnu prefix=/usr \
&& cp ../jpegint.h /usr/include/jpegint.h \
&& pip install --upgrade --no-cache-dir --force-reinstall --no-binary :all: --compile -v Pillow


USER user
VOLUME /data

ENTRYPOINT ["optimize-images"]
