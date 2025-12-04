DOCKER = docker-compose

LOGIN = cbrito-s

build:
	$(DOCKER) build

up:
	$(DOCKER) up -d

down:
	$(DOCKER) down

clean:

logs:
	$(DOCKER) logs -f

.PHONY: build up down clean logs
