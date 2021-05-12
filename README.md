# Docker Compose PHP Server 

High speed low drag PHP using Docker.

## Quick start

Make sure you have Docker and Docker Compose installed.

[https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

[https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

From the directory root of the project run `docker-compose up` open your browser to 
[http://localhost:8001](http://localhost:8001).

To stop the Docker container, from the Docker CLI windows press [Control]-C.

## To change the PHP code

Edit the `docker-compose.yml` file changing the `/app` path appropriately.

## To change the PHP version

Stop the Docker containers.

Do a search and replace in the file `docker-compose.yml` for `php8` with `php5` or `php7`.

Then run `docker-compose build`.

Next, start the docker container by running `docker-compose up`.

## SSH Keys

The current configuration will look for an SSH key in `~/.ssh/id_rsa`.

## Composer

PHP Composer [https://getcomposer.org/](https://getcomposer.org/) is installed by default and can be run inside
the server container with the command `composer`.

## PHP Testing

Several tools for testing PHP code are installed by default.

### PHPUnit

PhpUnit [https://phpunit.de/](https://phpunit.de/) is installed by default and can be run inside the server 
container with `phpunit`.

### Codeception

Codeception [https://codeception.com/](https://codeception.com/) is installed by default and can be run inside
the server container with `codeception`.

### Other code testing tools

Other tools included in the container are phing, phpcpd, phploc, phpmd and php_codesniffer.

## XDebug

XDebug is installed and configured separately for the command line (CLI) and web (HTTP).

### Command Line (CLI)

The XDebug configuration for the command line can be found in `./docker/cli.ini` for each version of PHP.

The command line is not configured for debugging by default, but is configured for profiling and coverage.  
This is to support PHPUnit and Codeception.  It also keeps the IDE debugger from being triggered by the PHP
cli tools.

### Web (HTTP)

The XDebug configuration for the web can be found in `./dockerfile/http.ini` for each version of PHP.

The web is configured for debugging and development by default.  By having you IDE listen for a XDebug connection
on port 9000, you should be able to set breakpoint and inspect variables in your IDE.

## MariaDB

The `docker-compose.yml` includes a MariaDB server and PhpMyAdmin setup by default.  It is set up to allow quick 
access to the database using a browser.  

To access the PhpMyAdmin tool open [http://localhost:9082](http://localhost:9082).

To change the default database name, edit the `docker-compose.yml` file and change "database_name" to your 
default database name.

### Startup DB

A startup database can be created by placing a scrip in the `docker-entrypoint-initdb.d` directory.  See the README.md
file in that directory for detail.

## Redis

The `docker-compose.yml` include a Redis cache server by default.  Most scalable PHP environments use Redis 
to improve performance.  

To access to Redis web tool open [http://localhost:9083](http://localhost:9083).

# Performance Testing

TBD

for later: https://gist.github.com/kelvinn/6a1c51b8976acf25bd78
