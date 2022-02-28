#!/bin/bash
docker pull php:7.4-alpine || true
docker pull riamehdi/gitlab-ci-pipeline-php:7.4-alpine || true
docker build --compress --cache-from riamehdi/gitlab-ci-pipeline-php:7.4-alpine --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" -t riamehdi/gitlab-ci-pipeline-php:7.4-alpine -f php/7.4/alpine/Dockerfile-lts .
docker run -t --rm -v "$(pwd)":/var/www/html riamehdi/gitlab-ci-pipeline-php:7.4-alpine goss -g tests/goss-lts.yaml v
docker tag riamehdi/gitlab-ci-pipeline-php:7.4-alpine riamehdi/gitlab-ci-pipeline-php:7.4-alpine
docker push riamehdi/gitlab-ci-pipeline-php:7.4-alpine
