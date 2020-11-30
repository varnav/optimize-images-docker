#!/bin/bash
docker build --no-cache mozjpeg -t varnav/optimize-images -t varnav/optimize-images:mozjpeg
docker build --no-cache libjpeg -t varnav/optimize-images:libjpeg
docker build --no-cache experimental -t varnav/optimize-images:experimental
docker push varnav/optimize-images