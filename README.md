# OAuth2 Server 

An OAuth2 server written in PHP that can be quickly modified to meet specific needs.

## Quick start

Make sure you have Docker and Docker Compose installed.

    https://docs.docker.com/get-docker/

    https://docs.docker.com/compose/install/

From the root of the project run `docker-compose up` open your browser to 
[http:\\localhost:8001](http:\\localhost:8001).

To stop the Docker container, from the Docker CLI windows press [Control]-C.

## To change the PHP code

The "webroot" is the app directory, with html being the directory where php is served from.  Change the code in 
html to change the PHP code.

## To change the PHP version

Stop the Docker containers.

Change the line `.docker/php8.dev.dockerfile` to `.docker/php7.dev.dockerfile` or `.docker/php5.dev.dockerfile`.

Then `docker-compose build`.

Next, restart the docker container `docker-compose up`.