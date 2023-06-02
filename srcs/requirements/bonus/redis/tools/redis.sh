#!/bin/sh

# Check if the Redis configuration backup file exists
if [ ! -f "/etc/redis/redis.conf.bak" ]; then

    # Create a backup of the Redis configuration file
    cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
    # We create the .bak to notify the program that it exists, so it doesn't go into the loop anymore

    # Comment out the default bind address to allow connections from all interfaces
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf

    # Set a Redis password (if required)
    # Uncomment the line and replace $REDIS_PWD with the actual password
    # sed -i "s|# requirepass foobared|requirepass $REDIS_PWD|g" /etc/redis.conf

    # Set the maximum memory limit to 2 megabytes
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf

    # Set the maximum memory eviction policy to allkeys-lru
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

fi

# Start the Redis server with protected mode disabled
redis-server --protected-mode no
