
DOCKER_COMPOSE := docker-compose -f srcs/docker-compose.yml
# -f = specify the location of the compose file


# define standard colors
_END			:=	\033[0m
_GREEN			:=	\033[32m

all: up

up:
	@echo "$(_GREEN) Rebuild and start all the containers in detached mode$(_END)"
	${DOCKER_COMPOSE} up -d --build
# -d = run the containers in the background (terminal is still usable while running)
# --build = force to rebuild the images of the services

build:
	@echo "$(_GREEN)Build images$(_END)"
	$(DOCKER_COMPOSE) build

start:
	@echo "$(_GREEN)Start containers$(_END)"
	$(DOCKER_COMPOSE) start

restart:
	@echo "$(_GREEN)Restart containers$(_END)"
	$(DOCKER_COMPOSE) restart

stop:
	@echo "$(_GREEN)Stop containers$(_END)"
	$(DOCKER_COMPOSE) stop

down:
	@echo "$(_GREEN)Stop and remove containers, volumes and networks$(_END)"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
# --rmi all = remove all images associated with the services
# --volumes = remove any volume
# --remove-orphans = remove any container unused by docker-compose file

ls:
	@echo "$(_GREEN)------------------------List running containers-------------------------$(_END)"
	$(DOCKER_COMPOSE) ps
	@echo "$(_GREEN)------------------------------List images-------------------------------$(_END)"
	docker images
	@echo "$(_GREEN)------------------------------List volumes------------------------------$(_END)"
	docker volume ls

clean: down

fclean: clean
	@echo "$(_GREEN)Removes images, containers and volumes$(_END)"
	sudo rm -rf /home/$(USER)/data/wordpress/*
	sudo rm -rf /home/$(USER)/data/mysql/*

prune: fclean
	@echo "$(_GREEN)Removes all unused images, containers, networks and volumes$(_END)"
	sudo docker system prune -f -a
# -f = force the removal without confirmation
# -a = remove all objects including unused

re: fclean all

.PHONY: all build up start restart stop down ls clean fclean prune re