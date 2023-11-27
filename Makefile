DOCKER := $(shell command -v docker 2> /dev/null || command -v podman 2> /dev/null)
COMPOSE := $(DOCKER) compose

# Phony targets for common actions

.PHONY: up down ps exec-nginx exec-php-7.1 exec-php-7.4 logs clean

# Variables for executing commands in containers

dir ?= .                 # Default directory to change to before executing commands
cmd ?= sh                # Default command to execute

# Build and start the Docker containers

up:
	$(COMPOSE) up -d --force-recreate
	# This command starts all containers in the background (-d) and recreates them
	# even if they already exist (-f --force-recreate).

build:
	$(COMPOSE) build --no-cache
	# This command builds all Docker images from scratch (--no-cache).

# Stop and remove the Docker containers

down:
	$(COMPOSE) down
	# This command stops and removes all running containers.

# List the running Docker containers

ps:
	$(COMPOSE) ps
	# This command lists all running Docker containers.

# Execute a command in the Nginx container

exec-nginx:
	$(COMPOSE) exec nginx sh
	# This command executes the `sh` shell in the `nginx` container.

# Execute a command in the PHP 7.1 container

exec-php-7.1:
	$(COMPOSE) exec php-fpm-7.1 sh -c "cd $(dir) && $(cmd)"
	# This command executes the specified `cmd` (default: `sh`) in the `php-fpm-7.1`
	# container, after changing the working directory to `$(dir)` (default: `.`).

# Execute a command in the PHP 7.4 container

exec-php-7.4:
	$(COMPOSE) exec php-fpm-7.4 sh -c "cd $(dir) && $(cmd)"
	# Similar to `exec-php-7.1`, but for the `php-fpm-7.4` container.

# Execute a command in the Composer container

exec-composer:
	$(COMPOSE) run --rm composer sh -c "cd $(dir) && $(cmd)"
	# This command executes the specified `cmd` (default: `sh`) in a temporary
	# `composer` container, after changing the working directory to `$(dir)`
	# (default: `.`). The `--rm` flag removes the container after execution.

# Execute a command in the Node container

exec-node:
	$(COMPOSE) run --rm node sh -c "cd $(dir) && $(cmd)"
	# Similar to `exec-composer`, but for the `node` container.

# Display logs from all containers
logs:
	$(COMPOSE) logs -f
	# This command displays logs from all running containers in real time.

# Display logs from specific containers
log-nginx:
	$(COMPOSE) logs -f nginx
	# Displays logs from the `nginx` container in real time.

log-php-7.1:
	$(COMPOSE) logs -f php-fpm-7.1
	# Displays logs from the `php-fpm-7.1` container in real time.

log-php-7.4:
	$(COMPOSE) logs -f php-fpm-7.4
	# Displays logs from the `php-fpm-7.4` container in real time.

log-composer:
	$(COMPOSE) logs -f composer
	# Displays logs from the temporary `composer` container in real time.

log-node:
	$(COMPOSE) logs -f node
	# Displays logs from the temporary `node` container in real time.

# Remove all containers and volumes, including orphaned ones

clean:
	$(COMPOSE) down -v --remove-orphans
	# This command stops and removes all running containers (`down`), removes all
	# volumes (`-v`), and removes all orphaned volumes and containers (`--remove-orphans`).
