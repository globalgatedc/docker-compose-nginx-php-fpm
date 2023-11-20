DOCKER := $(shell command -v docker 2> /dev/null || command -v podman 2> /dev/null)
COMPOSE := $(DOCKER) compose

.PHONY: up down ps exec-nginx exec-php-7.1 exec-php-7.4 logs clean

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

ps:
	$(COMPOSE) ps

exec-nginx:
	$(COMPOSE) exec nginx bash

exec-php-7.1:
	$(COMPOSE) exec php-fpm-7.1 bash

exec-php-7.4:
	$(COMPOSE) exec php-fpm-7.4 bash

# usage: make exec-composer dir=../project cmd="composer install"
exec-composer:
	$(COMPOSE) run --rm --user $(id -u):$(id -g) composer bash -c "cd $(dir ?= .) && $(cmd ?= bash)"

exec-node:
	$(COMPOSE) run --rm --user $(id -u):$(id -g) node sh

logs:
	$(COMPOSE) logs -f

clean:
	$(COMPOSE) down -v --remove-orphans
