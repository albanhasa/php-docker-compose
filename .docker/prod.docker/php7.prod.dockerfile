FROM php:7-apache

############################################################################
# Install Apache modules
############################################################################
RUN a2enmod rewrite