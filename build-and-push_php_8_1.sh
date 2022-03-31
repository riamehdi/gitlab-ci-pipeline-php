#!/bin/bash
docker pull php:8.1-fpm || true
docker pull riamehdi/gitlab-ci-pipeline-php:8.1-fpm || true
docker build --compress --cache-from riamehdi/gitlab-ci-pipeline-php:8.1-fpm --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" -t riamehdi/gitlab-ci-pipeline-php:8.1-fpm -f php/8.1/fpm/Dockerfile .
docker run -t --rm -v "$(pwd)":/var/www/html riamehdi/gitlab-ci-pipeline-php:8.1-fpm goss -g tests/goss-8.1.yaml v
docker tag riamehdi/gitlab-ci-pipeline-php:8.1-fpm riamehdi/gitlab-ci-pipeline-php:8.1
docker push riamehdi/gitlab-ci-pipeline-php:8.1
