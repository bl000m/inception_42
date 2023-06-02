
DOCKER_COMPOSE := docker-compose -f srcs/docker-compose.yml

all: up

up:
	@echo "Rebuild and start all the containers in detached mode"
	${DOCKER_COMPOSE} up -d --build

build:
	@echo "Build images"
	$(DOCKER_COMPOSE) build

start:
	@echo "Start containers"
	$(DOCKER_COMPOSE) start

restart:
	@echo "Restart containers"
	$(DOCKER_COMPOSE) restart

stop:
	@echo "Stop containers"
	$(DOCKER_COMPOSE) stop

down:
	@echo "Stop and remove containers, volumes and networks"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

clean: down

fclean: clean
	@echo "Removes images, containers and volumes"
	sudo rm -rf /home/$(USER)/data/wordpress/*
	sudo rm -rf /home/$(USER)/data/mysql/*

prune: fclean
	@echo "Removes all unused images, containers, networks and volumes"
	sudo docker system prune -f -a

re: fclean all

.PHONY: all build up start restart stop down clean fclean prune re