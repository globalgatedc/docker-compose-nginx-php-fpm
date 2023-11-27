DOCKER := $(shell command -v docker 2> /dev/null || command -v podman 2> /dev/null)
COMPOSE := $(DOCKER) compose

.PHONY: up down ps exec-nginx exec-php-7.1 exec-php-7.4 logs clean

# vars for exec $cmd on $dir
dir ?= .
cmd ?= sh

up:
	$(COMPOSE) up -d --force-recreate

build:
	$(COMPOSE) build --no-cache

down:
	$(COMPOSE) down

ps:
	$(COMPOSE) ps

exec-nginx:
	$(COMPOSE) exec nginx sh

exec-php-7.1:
	$(COMPOSE) exec php-fpm-7.1 sh -c "cd $(dir) && $(cmd)"

exec-php-7.4:
	$(COMPOSE) exec php-fpm-7.4 sh -c "cd $(dir) && $(cmd)"

exec-composer:
	$(COMPOSE) run --rm composer sh -c "cd $(dir) && $(cmd)"

exec-node:
	$(COMPOSE) run --rm node sh -c "cd $(dir) && $(cmd)"

logs:
	$(COMPOSE) logs -f

log nginx:
	$(COMPOSE) logs -f nginx

log php-7.1:
	$(COMPOSE) logs -f php-fpm-7.1

log php-7.4:
	$(COMPOSE) logs -f php-fpm-7.4

log composer:
	$(COMPOSE) logs -f composer

log node:
	$(COMPOSE) logs -f node

clean:
	$(COMPOSE) down -v --remove-orphans
