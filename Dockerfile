# Use the official PHP 5.4 image as the base
FROM php:5.4-apache

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libmysqlclient-dev \
    mysql-client \
    git \
    unzip

# Install PHP MySQL extension
RUN docker-php-ext-install mysqli

# Copy the application code into the container
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install Composer dependencies
RUN composer install --no-dev

# Expose the Apache web server port
EXPOSE 80

# Start the Apache web server
CMD ["apache2-foreground"]

