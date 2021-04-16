#!/bin/bash
docker build --no-cache . -t varnav/optimize-images
docker push varnav/optimize-images