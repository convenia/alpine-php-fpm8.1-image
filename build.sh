#!/usr/bin/env bash
docker build --pull --no-cache -t convenia/php:8.1-development .
docker build --pull -t convenia/php:8.1-production --build-arg ENVIRONMENT=production .
docker push convenia/php:8.1-development
docker push convenia/php:8.1-production