FROM debian:buster

RUN		apt-get update
RUN		apt-get install -y redis \
		&& rm -rf /var/lib/apt/lists/*

COPY ./tools/redis.sh /tmp/redis.sh

EXPOSE 6379

CMD ["sh", "/tmp/redis.sh"]

# to check if redis is running:
# docker exec -it redis bash: This command allows you to access the shell inside the running Redis container named "redis". The -it flags allocate a pseudo-TTY and keep STDIN open, which allows you to interact with the shell inside the container.

# redis-cli -h localhost: Once inside the Redis container's shell, the redis-cli command is executed. This command starts the Redis command-line interface, which is a tool used to interact with Redis servers. The -h localhost option specifies that the Redis server is running on the same container, using the hostname "localhost".

# localhost:6379>: After executing the redis-cli command, you are now presented with the Redis prompt, indicating that you are connected to the Redis server running on the specified host and port (localhost:6379). The prompt shows the host and port information followed by a greater-than sign (>).

# ping: The ping command is then executed within the Redis prompt. This command is used to check if the Redis server is running and reachable. If the server is active and responsive, it will return the response "PONG". This response confirms that the Redis server is up and running.