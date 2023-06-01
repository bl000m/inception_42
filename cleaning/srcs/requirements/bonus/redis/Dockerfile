FROM debian:buster

# Update package lists
RUN apt-get update

# Install Redis server and remove package lists to reduce image size
RUN apt-get install -y redis \
    && rm -rf /var/lib/apt/lists/*

# Copy Redis shell script to the container
COPY tools/redis.sh /tmp/redis.sh

# Expose Redis default port
EXPOSE 6379

# Run the Redis shell script as the default command
CMD ["sh", "/tmp/redis.sh"]

# -----

# Instructions to check if Redis is running:

# To check if Redis is running, you can access the shell inside the running Redis container.
# Execute the following command:
# docker exec -it redis bash
# This command allows you to access the shell inside the running Redis container named "redis".
# The -it flags allocate a pseudo-TTY and keep STDIN open, which allows you to interact with the shell inside the container.

# Once inside the Redis container's shell, you can start the Redis command-line interface.
# Execute the following command:
# redis-cli -h localhost
# This command starts the Redis command-line interface, which is a tool used to interact with Redis servers.
# The -h localhost option specifies that the Redis server is running on the same container, using the hostname "localhost".

# After executing the redis-cli command, you will be presented with the Redis prompt.
# The prompt indicates that you are connected to the Redis server running on the specified host and port (localhost:6379).
# The prompt shows the host and port information followed by a greater-than sign (>).

# To check if Redis is running and reachable, you can execute the ping command within the Redis prompt.
# The ping command is used to send a ping request to the Redis server and check its response.
# If the server is active and responsive, it will return the response "PONG".
# This response confirms that the Redis server is up and running.
