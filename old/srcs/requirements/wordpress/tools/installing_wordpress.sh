
# if [-f ./wp-config.php]
# then
#     echo "wordpress already downloaded"
# else
cd /var/www/html/wordpress
# Change directory to /var/www/html/wordpress

wp core download --path="/var/www/html/wordpress" --allow-root
# DOWNLOAD WORDPRESS FILES: Download the WordPress core files to the specified path (/var/www/html/wordpress) while allowing root user privileges.

wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_
# GENERATE AND CONFIGURE THE WP-CONFIG.PHP FILE: Create the wp-config.php file with the specified database details (database name, username, password, host) and set the table prefix to 'wp_' in the specified path (/var/www/html/wordpress).

wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
# RUNS THE STANDARD WORDPRESS INSTALLATION PROCESS: Install WordPress and set up the necessary database tables. The provided parameters specify the site URL, site title, admin username, admin password, and admin email.

wp plugin update --allow-root --all
# UPDATE PLUGINS: Update all installed plugins.

wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD
# CREATE USER IN WORDPRESS: Create a new user in WordPress with the provided username, email, and password.

# wp theme install neve --activate --allow-root
# CHOOSE THEME: Install and activate the Neve theme. (This line is commented out in the provided commands.)

chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R
# GIVE PERMISSIONS TO GROUP AND USER WWW-DATA TO UPLOADS: Change ownership of the wp-content/uploads directory and its contents to the www-data user and group.

mkdir -p /run/php/
# Create a directory /run/php/ if it doesn't exist already.

php-fpm7.3 -F
# LAUNCH PHP-FPM: Start the PHP-FPM service (FastCGI Process Manager) using PHP version 7.3 in foreground mode.
# fi
# exec "$@"