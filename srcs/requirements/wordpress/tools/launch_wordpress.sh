#!/bin/sh

# Change directory to where the WordPress file will be downloaded
cd /var/www/html/wordpress

wp core download --path="/var/www/html/wordpress" --allow-root

wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_

wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

wp plugin update --allow-root --all

wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass="$WP_USER_PASSWORD"

mkdir -p /var/www/html/wordpress/wp-content/uploads

chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

mkdir -p /run/php/
# LAUNCH PHP-FPM
php-fpm7.3 -F
