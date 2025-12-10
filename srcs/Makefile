DOCKER = docker-compose

LOGIN = cbrito-s

build:
	$(DOCKER) build

up:
	$(DOCKER) up -d

down:
	$(DOCKER) down
	sudo rm -rf /home/cbrito-s/data

clean:

logs:
	$(DOCKER) logs -f

.PHONY: build up down clean logs
