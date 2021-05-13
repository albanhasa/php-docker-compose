FROM php:8

############################################################################
# Install system commands and libraries
############################################################################
RUN apt-get -y update \
    && apt-get install -y \
       curl \
       wget \
       git \
       zip \
       unzip

############################################################################
# Manage SSH keys https://medium.com/trabe/use-your-local-ssh-keys-inside-a-docker-container-ea1d117515dc
############################################################################
ENV GIT_SSL_NO_VERIFY="1"
RUN mkdir -p ~/.ssh \
    && chown -R root:root ~/.ssh \
    && echo "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config \
    && ln -s /run/secrets/ssh_key ~/.ssh/id_rsa

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
RUN curl -LsS https://codeception.com/codecept.phar -o /root/bin/codecept \
    && chmod u+x /root/bin/codecept

############################################################################
# Setup XDebug
############################################################################
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "export PHP_INI_SCAN_DIR=/cli.ini" >> ~/.bashrc