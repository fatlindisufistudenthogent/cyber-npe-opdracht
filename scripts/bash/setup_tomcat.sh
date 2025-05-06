#!/bin/bash

# Variabelen
IMAGE_NAME="ghostcat-tomcat"
CONTAINER_NAME="ghostcat"
TOMCAT_PORT_HTTP=8080
TOMCAT_PORT_AJP=8009
CURRENT_USER=$(whoami)

# Controleer of Docker is geïnstalleerd
if ! command -v docker &> /dev/null; then
    echo "Docker is niet geïnstalleerd. Installeren..."
    sudo apt update
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker is al geïnstalleerd."
fi

# Voeg de huidige gebruiker toe aan de docker-groep (indien nog niet gedaan)
if ! groups $CURRENT_USER | grep -q docker; then
    echo "Toevoegen van $CURRENT_USER aan de docker-groep..."
    sudo usermod -aG docker $CURRENT_USER
    echo "Gebruiker toegevoegd aan docker-groep. Log opnieuw in om wijzigingen toe te passen."
    # Forceer groepswijziging in huidige sessie (alternatief voor uitloggen)
    newgrp docker
else
    echo "$CURRENT_USER is al lid van de docker-groep."
fi

# Maak een .dockerignore om IBUS-cachefouten te vermijden
if [ ! -f .dockerignore ]; then
    echo "Aanmaken van .dockerignore..."
    echo ".cache" > .dockerignore
    echo ".dockerignore" >> .dockerignore
fi

# Bouw de Docker-image
echo "Bouwen van de Docker-image..."
docker build -t $IMAGE_NAME .

# Controleer of de container al draait, zo ja, stop en verwijder deze
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME draait al. Stoppen en verwijderen..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Start de container
echo "Starten van de Tomcat-container..."
docker run -d -p $TOMCAT_PORT_HTTP:8080 -p $TOMCAT_PORT_AJP:8009 --name $CONTAINER_NAME $IMAGE_NAME

# Controleer of de container draait
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Tomcat-container draait op poorten $TOMCAT_PORT_HTTP (HTTP) en $TOMCAT_PORT_AJP (AJP)."
    echo "Controleer toegang via: http://192.168.56.106:$TOMCAT_PORT_HTTP"
else
    echo "Fout: Container kon niet worden gestart."
    exit 1
fi

# Scan de poorten
if command -v nmap &> /dev/null; then
    echo "Scannen van poorten $TOMCAT_PORT_HTTP en $TOMCAT_PORT_AJP..."
    nmap localhost -p $TOMCAT_PORT_HTTP,$TOMCAT_PORT_AJP
else
    echo "Nmap niet geïnstalleerd. Installeer met: sudo apt install nmap (optioneel)."
fi