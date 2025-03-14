# Makefile for Docker Compose

# Name of the Docker Compose service (you can change this)
COMPOSE_FILE=./requuirements/docker-compose.yml



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

# Clean up unused Docker resources (images, containers, volumes, etc.)
prune:
	docker system prune -f

# Build and start the containers in one go
restart: down up

