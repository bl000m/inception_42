#!/bin/sh

# Move static website files
mv /tmp/index.html /var/www/html/wordpress/index.html
mv /tmp/style.css /var/www/html/wordpress/style.css
mv /tmp/images /var/www/html/wordpress/images

# Change directory to where the WordPress file will be downloaded
cd /var/www/html/wordpress

# Download WordPress core
wp core download --path="/var/www/html/wordpress" --allow-root

# Create WordPress configuration
wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_

# Install WordPress
wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

# Update all plugins
wp plugin update --allow-root --all

# Create a new user
wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass="$WP_USER_PASSWORD"

# Create uploads directory and set permissions
mkdir -p /var/www/html/wordpress/wp-content/uploads
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

# Configure Redis caching
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
wp config set WP_REDIS_CLIENT phpredis --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

# Launch PHP-FPM (FastCGI Process Manager)
# PHP-FPM is a FastCGI implementation for PHP that enables handling 
# of PHP requests by a separate pool of processes, improving performance 
# and resource utilization.
mkdir -p /run/php/
php-fpm7.3 -F
