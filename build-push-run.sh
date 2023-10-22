#!/bin/bash
source .env

# Build the Docker image
docker build -t $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME:$TAG -f ./build-image/Dockerfile build-image

# Check if the build was successful
if [ $? -eq 0 ]; then
      echo "Docker image build successfully."

      # Log in to Docker Hub (ensure you're already logged in)
      docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD

      # Tag the image for Docker Hub
      docker tag $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME:$TAG $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME:$TAG

      # Push the image to Docker Hub
      docker push $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME:$TAG

      # Check if the push was successful
      if [ $? -eq 0 ]; then
        echo "Docker image pushed to Docker Hub successfully."

        cat <<EOL > docker-compose.yml
version: '3'
services:
  web:
    image: $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME:$TAG
    container_name: devops-mif
    restart: always
    ports:
      - "80:80"
EOL

# Start the Docker containers using Docker Compose
docker-compose up -d

          # Check if the containers are running
          if [ $? -eq 0 ]; then
              echo "Docker containers started successfully."
              echo "You can access the PHP application at http://localhost."
          else
              echo "Error: Failed to start Docker containers."
          fi

      else
        echo "Error: Failed to push the Docker image to Docker Hub."
      fi
else
  echo "Error: Failed to build the Docker image."
fi