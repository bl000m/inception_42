#!/bin/sh

# Automate the installation and configuration of WordPress on the server
# Change directory to where the WordPress file will be downloaded

# # static website
# mv /tmp/index.html /var/www/html/wordpress/index.html

cd /var/www/html/wordpress

# Download WordPress files
wp core download --path="/var/www/html/wordpress" --allow-root

# Generate and configure wp-config.php - Including database connection info
wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_

# Install WordPress - configure URL / Title / Admin info
# Also creates WordPress tables in the database
wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

wp plugin update --allow-root --all

# Create a new user
wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass="$WP_USER_PASSWORD"

# Create the uploads directory
mkdir -p /var/www/html/wordpress/wp-content/uploads

# Set permissions for the uploads directory
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

# ---------redis--------
wp config set WP_REDIS_HOST redis --allow-root 
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
# ----------

# LAUNCH PHP-FPM
mkdir -p /run/php/
php-fpm7.3 -F
