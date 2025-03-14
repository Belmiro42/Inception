# Makefile for Docker Compose

# Name of the Docker Compose service (you can change this)
COMPOSE_FILE=docker-compose.yml

# Define services in Docker Compose (if you have specific ones, modify this)
SERVICES=wordpress mysql

# Build the Docker images defined in the Docker Compose file
build:
	docker-compose -f $(COMPOSE_FILE) build

# Start the services in the background
up:
	docker-compose -f $(COMPOSE_FILE) up -d

# Stop the services
down:
	docker-compose -f $(COMPOSE_FILE) down

# View the logs of the services
logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

# List running Docker Compose services
ps:
	docker-compose -f $(COMPOSE_FILE) ps

# Run a one-time command on a running container
exec:
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE) $(COMMAND)

# Clean up unused Docker resources (images, containers, volumes, etc.)
prune:
	docker system prune -f

# Build and start the containers in one go
restart: down up

# Run tests if you have any test containers
test:
	docker-compose -f $(COMPOSE_FILE) run --rm $(SERVICE) /bin/sh -c "your-tests-here"

