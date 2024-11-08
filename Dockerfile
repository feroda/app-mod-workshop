FROM php:7.4-apache

# # Use the official PHP 5.4 image as the base
# # Configure PHP for Cloud Run.
# # Precompile PHP code with opcache.
# RUN docker-php-ext-install -j "$(nproc)" opcache
# RUN set -ex; \
#   { \
#     echo "; Cloud Run enforces memory & timeouts"; \
#     echo "memory_limit = -1"; \
#     echo "max_execution_time = 0"; \
#     echo "; File upload at Cloud Run network limit"; \
#     echo "upload_max_filesize = 32M"; \
#     echo "post_max_size = 32M"; \
#     echo "; Configure Opcache for Containers"; \
#     echo "opcache.enable = On"; \
#     echo "opcache.validate_timestamps = Off"; \
#     echo "; Configure Opcache Memory (Application-specific)"; \
#     echo "opcache.memory_consumption = 32"; \
#   } > "$PHP_INI_DIR/conf.d/cloud-run.ini"


#KO: libmysqlclient-dev \
#KO: mysql-client \
# Install necessary packages
RUN apt-get update && apt-get install -y \
    libmariadb-dev-compat libmariadb-dev \
    mariadb-client \
    git \
    unzip

# Install PHP MySQL extension
#KO Gemini: RUN docker-php-ext-install mysqli
RUN docker-php-ext-install -j5 mysqli pdo pdo_mysql

# Copy the application code into the container
COPY . /var/www/html

# Use the PORT environment variable in Apache configuration files.
# https://cloud.google.com/run/docs/reference/container-contract#port
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# Set the working directory
WORKDIR /var/www/html

# Expose the Apache web server port
EXPOSE 8080

# Start the Apache web server
CMD ["apache2-foreground"]

