# Docker Compose PHP Server 

High speed low drag PHP using Docker.

## Quick start

Make sure you have Docker and Docker Compose installed.

[https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

[https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

From the directory root of the project run `docker-compose up` open your browser to 
[http:\\localhost:8001](http:\\localhost:8001).

To stop the Docker container, from the Docker CLI windows press [Control]-C.

## To change the PHP code

The "app" is the default app directory, with html being the directory where php is served from.  Change the code in 
html to change the PHP code.

Alternately you can edit the `docker-compose.yml` file changing the `/app` path appropriately.

## To change the PHP version

Stop the Docker containers.

In the `docker-compose.yml` file change the line `.docker/php8.dev.dockerfile` to `.docker/php7.dev.dockerfile` 
or `.docker/php5.dev.dockerfile`.

Then run `docker-compose build`.

Next, start the docker container by running `docker-compose up`.

## SSH Keys

## Composer

## PHP Testing

### PHHUnit

### Codeception

### Other code testing tools

## XDebug

## MariaDB

### Startup DB

## Redis
