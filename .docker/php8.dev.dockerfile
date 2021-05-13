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
# Setup XDebug https://xdebug.org/download/historical
# xdebug-x.x.x for specific version
############################################################################
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "export PHP_INI_SCAN_DIR=/cli.ini" >> ~/.bashrc

############################################################################
# Create proper security higene for enviornemnt.
# Manage SSH keys https://medium.com/trabe/use-your-local-ssh-keys-inside-a-docker-container-ea1d117515dc
############################################################################
ENV GIT_SSL_NO_VERIFY="1"
RUN useradd -m user \
    && mkdir -p /home/user/.ssh \
    && echo "Host *\n\tStrictHostKeyChecking no\n" >> /home/user/.ssh/config \
    && chown -R user:user /home/user/.ssh
USER user
WORKDIR /app
CMD ["/bin/bash"]

############################################################################
# Install PHP Composer https://getcomposer.org/download/
# Add "--version=1.10.22" after "php --" to get a specific version.
############################################################################
RUN cd ~ \
    && mkdir bin \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer \
    && chmod u+x ~/bin/composer
# Add our script files to the path so they can be found
ENV PATH ~/bin:~/.composer/vendor/bin:$PATH

#############################################################################
# Setup PHP developer tools
#############################################################################
RUN ~/bin/composer -n --no-ansi global require \
       phpunit/phpunit \
       phing/phing \
       sebastian/phpcpd \
       phploc/phploc \
       phpmd/phpmd \
       squizlabs/php_codesniffer

############################################################################
# Isntall Codeception native
############################################################################
RUN curl -LsS https://codeception.com/codecept.phar -o ~/bin/codecept \
    && chmod u+x ~/bin/codecept

