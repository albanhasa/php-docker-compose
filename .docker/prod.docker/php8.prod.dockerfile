FROM php:8-apache

############################################################################
# Install Apache modules
############################################################################
RUN a2enmod rewrite