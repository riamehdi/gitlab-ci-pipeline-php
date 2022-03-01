FROM php:7.4

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Eduardo Bizarro <edbizarro@gmail.com>" \
  PHP="7.4" \
  NODE="14.17.3" \
  org.label-schema.name="edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.description=":coffee: Docker images for build and test PHP applications with Gitlab CI (or any other CI plataform!)" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-url="https://github.com/edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.vcs-ref=$VCS_REF

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV NVM_DIR $HOME/.nvm
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV GOSS_VERSION="0.3.16"
ENV PHP_VERSION=7.4
ENV NODE_VERSION="14.18.0"
ENV NPM_FETCH_RETRIES=2
ENV NPM_FETCH_RETRY_FACTOR=10
ENV NPM_FETCH_RETRY_MINTIMEOUT=10000
ENV NPM_FETCH_RETRY_MAXTIMEOUT=60000

USER root

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

# Install2
RUN bash ./packages.sh \
  && bash ./extensions.sh

# install node
# Install nvm (A Node Version Manager)
RUN mkdir -p $NVM_DIR && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
      && . $NVM_DIR/nvm.sh \
      && nvm install ${NODE_VERSION} \
      && nvm use ${NODE_VERSION} \
      && nvm alias ${NODE_VERSION} \
      && npm config set fetch-retries ${NPM_FETCH_RETRIES} \
      && npm config set fetch-retry-factor ${NPM_FETCH_RETRY_FACTOR} \
      && npm config set fetch-retry-mintimeout ${NPM_FETCH_RETRY_MINTIMEOUT} \
      && npm config set fetch-retry-maxtimeout ${NPM_FETCH_RETRY_MAXTIMEOUT} \
      && ln -s `npm bin --global` $HOME/.node-bin

RUN node --version
RUN npm --version

RUN adduser --disabled-password --gecos "" $IMAGE_USER && \
  echo "PATH=$(yarn global bin):$PATH" >> /root/.profile && \
  echo "PATH=$(yarn global bin):$PATH" >> /root/.bashrc && \
  echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
  mkdir -p /var/www/html \
  && composer global require "hirak/prestissimo:^0.3"  \
  && rm -rf ~/.composer/cache/* \
  && chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME \
  && curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh \
  && bash ./cleanup.sh

USER $IMAGE_USER

WORKDIR /var/www/html
