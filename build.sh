#!/usr/bin/env bash
docker build -t convenia/php:8.0-development .
docker build -t convenia/php:8.0-production --build-arg ENVIRONMENT=production .
docker push convenia/php:8.0-development
docker push convenia/php:8.0-production