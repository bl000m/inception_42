# Dockerfile for running cAdvisor

# cAdvisor (Container Advisor) is an open-source tool for monitoring and analyzing resource usage and performance characteristics of running containers.
# This Dockerfile sets up cAdvisor inside a Docker container.

FROM debian:buster

# Update the system
RUN apt update -y

# Install wget to download cAdvisor and download cAdvisor binary
RUN apt install wget -y && wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor && chmod +x cadvisor

# Uncomment the following lines if you are running on ARM64 architecture
# RUN apt install wget -y && wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-arm64 && mv cadvisor-v0.47.0-linux-arm64 cadvisor && chmod +x cadvisor

# Run cAdvisor
CMD ["./cadvisor"]

# Accessing cAdvisor:
# To access the cAdvisor browser interface, follow these steps:
# 1. Open a terminal or command prompt.
# 2. Execute the following command to retrieve the IP address of the cAdvisor container: 
#    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cadvisor
#    This command extracts and displays the IP address of the running cAdvisor container.
# 3. Open a web browser and enter the IP address obtained from the previous step, followed by :8080.
#    For example, if the IP address is 172.17.0.2, enter http://172.17.0.2:8080 in the browser.
#    This will access the cAdvisor browser interface, allowing you to monitor and analyze container metrics.

