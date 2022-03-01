#!/bin/bash
docker pull php:7.4-fpm || true
docker pull riamehdi/gitlab-ci-pipeline-php:7.4-fpm || true
docker build --compress --cache-from riamehdi/gitlab-ci-pipeline-php:7.4-fpm --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" -t riamehdi/gitlab-ci-pipeline-php:7.4-fpm -f php/7.4/Dockerfile .
docker run -t --rm -v "$(pwd)":/var/www/html riamehdi/gitlab-ci-pipeline-php:7.4-fpm goss -g tests/goss-7.4.yaml v
docker tag riamehdi/gitlab-ci-pipeline-php:7.4-fpm riamehdi/gitlab-ci-pipeline-php:7.4-fpm
docker push riamehdi/gitlab-ci-pipeline-php:7.4-fpm
