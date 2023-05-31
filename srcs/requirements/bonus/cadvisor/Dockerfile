# to access cAdvisor browser interface
# type this command in bash: docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cadvisor
# to get the address ip of the container running cAdvisor and type it in the browser with :8080 port specified at the end

FROM debian:buster


RUN apt update -y
# RUN apt install wget -y && wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor && chmod +x cadvisor
RUN apt install wget -y && wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-arm64 && mv cadvisor-v0.47.0-linux-arm64 cadvisor && chmod +x cadvisor

CMD ["./cadvisor"]