# Arguments, we need to define this before any FROM entries
ARG COMPOSER_VERSION="2.2"

FROM composer:${COMPOSER_VERSION} AS composer_binary

FROM gitpod/workspace-base

# Arguments
ARG NODE_VERSION=16
ARG APACHE_DOCROOT_IN_REPO="public"
ARG PHP_VERSION="8.2"

# Environment
ENV NODE_VERSION=${NODE_VERSION}
ENV COMPOSER_VERSION=${COMPOSER_VERSION}
ENV PNPM_HOME=/home/gitpod/.pnpm
ENV PATH=/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:/home/gitpod/.yarn/bin:${PNPM_HOME}:$PATH
## The directory relative to your git repository that will be served by Apache
ENV APACHE_DOCROOT_IN_REPO=${APACHE_DOCROOT_IN_REPO}
ENV PHP_VERSION=${PHP_VERSION}

USER root

# Install composer
COPY --from=composer_binary /usr/bin/composer /usr/bin/composer

# Install everything related to php and apache2
# Based on https://github.com/gitpod-io/workspace-images/tree/main/chunks/tool-nginx
# Check https://launchpad.net/~ondrej for more php extensions
RUN for _ppa in 'ppa:ondrej/php' 'ppa:ondrej/apache2'; do add-apt-repository -y "$_ppa"; done \
    && install-packages \
        apache2 \
        php \
        php-all-dev \
        php-bcmath \
        php-common \
        php-curl \
        php-date \
        php-fpm \
        php-gd \
        php-intl \
        php-json \
        php-mbstring \
        php-mysql \
        php-net-ftp \
        php-pear \
        php-redis \
        php-sqlite3 \
        php-tokenizer \
        php-xml \
        php-zip \
    && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load \
    && chown -R gitpod:gitpod /etc/apache2 /var/run/apache2 /var/lock/apache2 /var/log/apache2 \
    && update-alternatives --set php /usr/bin/php${PHP_VERSION} \
    && update-alternatives --set php-config /usr/bin/php-config${PHP_VERSION}

COPY --chown=gitpod:gitpod .devEnv/ /etc/apache2/

COPY .devEnv/gitpod/config/apache2/apache2.conf /etc/apache2/apache2.conf
COPY .devEnv/gitpod/config/apache2/envvars /etc/apache2/envvars
COPY --chown=gitpod:gitpod .devEnv/gitpod/tools/phpinfo.php /var/www/html/tools/phpinfo.php

# Enable apache modules
RUN a2enmod headers \
    && a2enmod rewrite \
    && a2enmod proxy \
    && a2enmod proxy_fcgi \
    && a2enmod proxy_http \
    && a2enmod ssl

# Install additional packages
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash \
    && curl -1sLf 'https://dl.cloudsmith.io/public/friendsofshopware/stable/setup.deb.sh' | sudo -E bash \
    && sudo apt install -y \
    symfony-cli \
    shopware-cli \
    mysql-client-8.0

# Install nodejs, yarn
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \
        && nvm install v${NODE_VERSION} \
        && nvm alias default v${NODE_VERSION} \
        && npm install -g typescript yarn pnpm node-gyp" \
    && echo ". ~/.nvm/nvm-lazy.sh"  >> /home/gitpod/.bashrc.d/50-node
# above, we are adding the lazy nvm init to .bashrc, because one is executed on interactive shells, the other for non-interactive shells (e.g. plugin-host)
COPY --chown=gitpod:gitpod ./.devEnv/gitpod/scripts/nvm-lazy.sh /home/gitpod/.nvm/nvm-lazy.sh

# Clean up
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

USER gitpod