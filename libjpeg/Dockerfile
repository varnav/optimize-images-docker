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

USER user
VOLUME /data

ENTRYPOINT ["optimize-images"]
