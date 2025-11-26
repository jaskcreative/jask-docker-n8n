# Container Name: N8N
# File Name: Makefile
# Description: Makefile for managing the N8N Docker service stack.
# Docker Internal Network: jask-internal-net
# Version: 1.0.0
# Author: Jask Creative

# SERVICE = n8n

# Makefile Targets, prevent conflicts with file names
.PHONY: up down update backup restore-postgres rebuild

# Start the service in detached mode
up:
	# Build and start all containers in detached mode
	docker compose up -d

# Stop and remove containers, networks, and volumes
down:
	# Stop and remove all containers, networks and volumes created by compose
	docker compose down

# Update the service by pulling the latest code and images
update:
	# Pull the latest images from the registry and update the repository
	docker compose pull
	# Rebuild the containers with the latest code

# Create a backup of the database and Qdrant data
backup:
	# Call backup script that loads .env and runs pg_dump
	bash ./make-backup.sh

# Restore the database from a backup file
restore-postgres:
	# Call restore script that loads .env and runs pg_restore
	bash ./make-restore-postgres.sh

# Full rebuild: purge volumes, pull fresh images, rebuild from scratch, and start
rebuild:
	# Stop the entire stack and remove containers, networks, and volumes
	docker compose down --volumes

	# Pull the latest images from the registry
	docker compose pull

	# Rebuild all images without cache
	docker compose build --no-cache

	# Start the full stack in detached mode
	docker compose up -d