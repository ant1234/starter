#!/bin/bash
apt-get update
apt-get -y install \
    	   libicu-dev \
           g++ \
    	   wget \
    	   git \
    	   zip \
    	   zlib1g-dev \
           libldap2-dev \
    	   libgd-dev \
    	   libzip-dev \
    	   libtidy-dev \
    	   libxml2-dev \
    	   libxslt-dev \
    	   curl \
    	   git-core \
    	   gzip \
    	   openssh-client \
    	   unzip \
    	   --no-install-recommends && \
apt-get autoremove -y && \
rm -rf /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) \
		   bcmath \
		   mysqli \
		   pdo \
		   pdo_mysql && \
apt-mark auto \
           zlib1g-dev \
           libicu-dev \
           g++ \
           libldap2-dev \
           libxml2-dev \
           libxslt-dev && \
docker-php-ext-configure intl && \
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
docker-php-ext-install -j$(nproc) \
           intl \
           ldap \
           gd \
           soap \
           tidy \
           xsl \
           zip && \
curl --silent --location https://deb.nodesource.com/setup_10.x | bash - && \
apt-get install --yes nodejs && \
npm install gulp -g && \
npm i gulp && \
apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
rm -rf /var/lib/apt/lists/* && \
echo install composer
chmod +x /var/www/html/docker/install_composer.sh
/var/www/html/docker/install_composer.sh
php composer.phar install
php /var/www/html/vendor/silverstripe/framework/cli-script.php dev/build
docker-php-entrypoint php-fpm
