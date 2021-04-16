FROM python:3

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Python optimize-images in Docker"
LABEL License="MIT License"

ARG DEBIAN_FRONTEND=noninteractive

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ARG MOZJPEG_VER=4.0.3

RUN set -ex \
&& groupadd --gid "$HOST_USER_GID" user \
&& useradd --uid "$HOST_USER_UID" --gid "$HOST_USER_GID" --create-home --shell /bin/bash user \
&& pip install pillow watchdog

### Code below will replace standard OS JPEG library with mozjpeg
### https://blog.avirtualhome.com/replace-jpeg-libraries-with-mozjpeg/

RUN set -ex \
&& apt-get update \
&& apt-get install --no-install-recommends -y libimagequant-dev libpng-dev libjpeg-dev wget ca-certificates build-essential cmake libtool autoconf automake m4 nasm pkg-config \
&& ldconfig /usr/lib \
&& cd /tmp \
&& wget https://github.com/mozilla/mozjpeg/archive/v${MOZJPEG_VER}.tar.gz \
&& tar xf v${MOZJPEG_VER}.tar.gz \
&& cd mozjpeg-${MOZJPEG_VER} \
&& mkdir build \
&& cd build \
&& cmake -G"Unix Makefiles" .. \
&& make -j4 install libdir=/usr/lib/x86_64-linux-gnu prefix=/usr \
&& cp ../jpegint.h /usr/include/jpegint.h \
&& pip install --upgrade --no-cache-dir --force-reinstall --no-binary :all: --compile -v Pillow \
&& apt-get remove -y libimagequant-dev libpng-dev libjpeg-dev build-essential cmake libtool autoconf automake m4 nasm pkg-config \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& cd /tmp \
&& rm -rf mozjpeg-${MOZJPEG_VER} \
&& pip install https://github.com/victordomingos/optimize-images/archive/refs/heads/master.zip


USER user
VOLUME /data

ENTRYPOINT ["optimize-images"]
