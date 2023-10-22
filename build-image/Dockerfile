# Use Alpine Linux as the base image
FROM alpine:latest

WORKDIR /var/www/html

# Install Nginx, PHP, and other required packages
RUN apk update && apk upgrade && \
    apk add --no-cache \
        curl \
        nginx \
        php82 \
        php82-ctype \
        php82-curl \
        php82-dom \
        php82-fileinfo \
        php82-fpm \
        php82-gd \
        php82-intl \
        php82-mbstring \
        php82-mysqli \
        php82-opcache \
        php82-openssl \
        php82-phar \
        php82-session \
        php82-tokenizer \
        php82-xml \
        php82-xmlreader \
        php82-xmlwriter \
        supervisor

# Copy Nginx configuration - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Copy Nginx configuration - default server
COPY config/conf.d /etc/nginx/conf.d/

# Configure PHP-FPM
ENV PHP_INI_DIR /etc/php82
COPY config/fpm-pool.conf ${PHP_INI_DIR}/php-fpm.d/www.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

# Create symlink for php
RUN ln -s /usr/bin/php82 /usr/bin/php

# Copy your PHP application code
COPY src/index.php /var/www/html/index.php

# Switch to use a non-root user from here on
USER nobody

# Add application
COPY --chown=nobody src/ /var/www/html/

# Expose port 80 for Nginx
EXPOSE 80

# Let supervisord Start Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
