
DOCKER_COMPOSE := docker-compose -f srcs/docker-compose.yml
# -f = specify the location of the compose file


# colors
_BACK			:=	\e[0m]
_YELLOW			:=	\e[1;32]

all: up

up:
	@echo "$(_YELLOW) Rebuild and start all the containers in detached mode$(_BACK)"
	${DOCKER_COMPOSE} up -d --build

build:
	@echo "$(_YELLOW)Build images$(_BACK)"
	$(DOCKER_COMPOSE) build

start:
	@echo "$(_YELLOW)Start containers$(_BACK)"
	$(DOCKER_COMPOSE) start

restart:
	@echo "$(_YELLOW)Restart containers$(_BACK)"
	$(DOCKER_COMPOSE) restart

stop:
	@echo "$(_YELLOW)Stop containers$(_BACK)"
	$(DOCKER_COMPOSE) stop

down:
	@echo "$(_YELLOW)Stop and remove containers, volumes and networks$(_BACK)"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
# --rmi all = rm(remove) all i(images)

containers:
	@echo "$(_YELLOW)List running containers$(_BACK)"
	$(DOCKER_COMPOSE) ps

images:
	@echo "$(_YELLOW)List images-$(_BACK)"
	docker images

volumes:
	@echo "$(_YELLOW)List volumes$(_BACK)"
	docker volume ls

clean: down

fclean: clean
	@echo "$(_YELLOW)Removes images, containers and volumes$(_BACK)"
	sudo rm -rf /home/$(USER)/data/wordpress/*
	sudo rm -rf /home/$(USER)/data/mysql/*

prune: fclean
	@echo "$(_YELLOW)Removes all unused images, containers, networks and volumes$(_BACK)"
	sudo docker system prune -f -a
# -a = all
# -f = force

re: fclean all

.PHONY: all build up start restart stop down containers images volumes clean fclean prune re