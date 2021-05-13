FROM php:5

############################################################################
# Install system commands and libraries
############################################################################
RUN apt-get -y update \
    && apt-get install -y \
       curl \
       wget \
       git \
       zip \
       unzip \
       zlib1g-dev \
       libpng-dev \
       libzip-dev \
       libldap2-dev

############################################################################
# Manage SSH keys https://medium.com/trabe/use-your-local-ssh-keys-inside-a-docker-container-ea1d117515dc
############################################################################
ENV GIT_SSL_NO_VERIFY="1"
RUN mkdir -p ~/.ssh
RUN chown -R root:root ~/.ssh
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
RUN ln -s /run/secrets/ssh_key ~/.ssh/id_rsa

############################################################################
# Install PHP Composer https://getcomposer.org/download/
############################################################################
RUN cd ~ \
    && mkdir bin \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/root/bin --filename=composer \
    && chmod u+x bin/composer
# Add our script files to the path so they can be found
ENV PATH /root/bin:~/.composer/vendor/bin:$PATH

#############################################################################
# Setup PHP developer tools
#############################################################################
RUN composer -n --no-ansi global require \
       phpunit/phpunit \
       phing/phing \
       sebastian/phpcpd \
       phploc/phploc \
       phpmd/phpmd \
       squizlabs/php_codesniffer

############################################################################
# Isntall Codeception native
############################################################################
RUN curl -LsS https://codeception.com/codecept.phar -o /usr/local/bin/codecept \
    && chmod a+x /usr/local/bin/codecept

############################################################################
# Setup XDebug Last PHP 5 version is 2.5.5
############################################################################
RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug
RUN echo "export PHP_INI_SCAN_DIR=/cli.ini" >> ~/.bashrc
