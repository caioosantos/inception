DOCKER = sudo docker compose
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
	sudo rm -rf /home/$(LOGIN)/data

logs:
	$(DOCKER) -f $(DOCKER_SRCS) logs -f

.PHONY: build up down clean logs
