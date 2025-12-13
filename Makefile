DOCKER = docker-compose
DOCKER_SRCS = ./srcs/docker-compose.yml
LOGIN = cbrito-s

build:
	$(DOCKER) -f $(DOCKER_SRCS) build

up:
	$(DOCKER) -f $(DOCKER_SRCS) up -d

down:
	$(DOCKER) -f $(DOCKER_SRCS) down
clean:
	$(DOCKER) -f $(DOCKER_SRCS) down --rmi local
	docker volume rm srcs_mysql srcs_wp_volume
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

logs:
	$(DOCKER) -f $(DOCKER_SRCS) logs -f

.PHONY: build up down clean logs
