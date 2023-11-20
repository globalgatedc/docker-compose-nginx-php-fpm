# Production-Ready Docker Compose Setup

This project utilizes Docker Compose to manage a production-ready environment with Nginx, PHP-FPM 7.1, and PHP-FPM 7.4 containers for different applications. The setup includes a convenient Makefile for managing the Docker Compose services.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Docker Installation](#docker-installation)
- [Makefile Commands](#makefile-commands)
- [Nginx Configuration](#nginx-configuration)
- [Security Considerations](#security-considerations)
- [Customization](#customization)

## Prerequisites

Make sure you have Docker and Docker Compose installed on your system. If Docker is not found, the Makefile will attempt to use Podman as a fallback.

- [Docker Installation](https://docs.docker.com/get-docker/)
- [Docker Compose Installation](https://docs.docker.com/compose/install/)

## Getting Started

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/your-repository.git
   cd your-repository
   ```

2. Create a `config/nginx/nginx.conf` file with a production-ready Nginx configuration. Ensure the configuration includes proper hardening, request limits, SSL settings, etc. (you can use the provided example as a starting point).

3. Create `docker/php-fpm-7.1/Dockerfile` and `docker/php-fpm-7.4/Dockerfile` for PHP-FPM 7.1 and PHP-FPM 7.4 respectively (you can use your own PHP configurations).

4. Adjust the volumes in the `docker-compose.yml` file to point to your application directories and configuration files.

5. Create a `Makefile` with the contents provided in this repository.

6. Run the following commands:

   ```bash
   # Start the Docker Compose services
   make up

   # View the status of the Docker Compose services
   make ps

   # Open a Bash shell in the Nginx container
   make exec-nginx

   # Open a Bash shell in the PHP-FPM 7.1 container
   make exec-php-7.1

   # Open a Bash shell in the PHP-FPM 7.4 container
   make exec-php-7.4

   # View logs from the Docker Compose services
   make logs

   # Stop and remove the Docker Compose services along with volumes
   make clean
   ```

## Docker Installation

The Docker installation instructions can vary based on your operating system. Please refer to the official Docker documentation for detailed installation instructions:

- [Docker Installation](https://docs.docker.com/get-docker/)

## Makefile Commands

- **`make up`:** Starts the Docker Compose services in the background.
- **`make down`:** Stops and removes the Docker Compose services.
- **`make ps`:** Lists the status of Docker Compose services.
- **`make exec-nginx`:** Opens a Bash shell in the Nginx container.
- **`make exec-php-7.1`:** Opens a Bash shell in the PHP-FPM 7.1 container.
- **`make exec-php-7.4`:** Opens a Bash shell in the PHP-FPM 7.4 container.
- **`make logs`:** Views logs from the Docker Compose services.
- **`make clean`:** Stops and removes the Docker Compose services along with volumes.

## Nginx Configuration

Ensure that your `config/nginx/nginx.conf` includes proper hardening, request limits, SSL settings, and follows best practices for a production environment. Make adjustments based on your specific security requirements.

## Security Considerations

Make sure to secure your Nginx configurations, PHP configurations, and application code before deploying in production.

## Customization

This setup is a starting point; customize the Nginx, PHP, and other configurations according to your production requirements. Review and adjust configurations based on your specific security and performance requirements.

Feel free to customize and expand upon these instructions based on the specifics of your project and deployment requirements.
