#!/bin/bash
docker build --compress -t riamehdi/gitlab-ci-pipeline-php:7.4 -f php/7.4/alpin/Dockerfile-lts .
docker tag riamehdi/gitlab-ci-pipeline-php:7.4-alpine riamehdi/gitlab-ci-pipeline-php:7.4-alpine
docker push riamehdi/gitlab-ci-pipeline-php:7.4-alpine
