#!/bin/bash

# Variabelen
IMAGE_NAME="ghostcat-tomcat"
CONTAINER_NAME="ghostcat"
TOMCAT_PORT_HTTP=8080
TOMCAT_PORT_AJP=8009
CURRENT_USER=$(whoami)
# Gebruik de directory van het script
WORKDIR="$(dirname "$(realpath "$0")")"

# Automatisch het IP-adres ophalen
UBUNTU_IP=$(ip -4 addr show | grep -v '127.0.0.1' | grep -oP 'inet \K[\d.]+' | head -n 1)
if [ -z "$UBUNTU_IP" ]; then
    echo "Fout: Kon geen IP-adres detecteren."
    exit 1
fi
echo "Gedetecteerd IP-adres: $UBUNTU_IP"

# Navigeer naar de scriptdirectory
cd "$WORKDIR" || {
    echo "Fout: Kan niet navigeren naar $WORKDIR"
    exit 1
}

# Controleer of Docker is geïnstalleerd
if ! command -v docker &>/dev/null; then
    echo "Docker is niet geïnstalleerd. Installeren..."
    apt-get update
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
else
    echo "Docker is al geïnstalleerd."
fi

# Voeg huidige gebruiker toe aan docker-groep
if ! groups "$CURRENT_USER" | grep -q docker; then
    echo "Toevoegen van $CURRENT_USER aan docker-groep..."
    usermod -aG docker "$CURRENT_USER"
    newgrp docker <<EOF
    echo "Gebruiker toegevoegd aan docker-groep."
EOF
fi

# Controleer of de Dockerfile bestaat
if [ ! -f "Dockerfile" ]; then
    echo "Fout: Dockerfile niet gevonden in $WORKDIR."
    exit 1
fi

# Bouw de Docker-image
echo "Bouwen van de Docker-image..."
docker build -t "$IMAGE_NAME" .

# Controleer of de container al draait
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME draait al. Stoppen en verwijderen..."
    docker stop "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
fi

# Start de container
echo "Starten van de Tomcat-container..."
docker run -d -p "$TOMCAT_PORT_HTTP:8080" -p "$TOMCAT_PORT_AJP:8009" --name "$CONTAINER_NAME" "$IMAGE_NAME"

# Controleer of de container draait
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Tomcat-container draait op poorten $TOMCAT_PORT_HTTP (HTTP) en $TOMCAT_PORT_AJP (AJP)."
    echo "Controleer toegang via: http://$UBUNTU_IP:$TOMCAT_PORT_HTTP"
else
    echo "Fout: Container kon niet worden gestart."
    docker logs "$CONTAINER_NAME"
    exit 1
fi

echo "Setup voltooid op $(date). Container: $CONTAINER_NAME, IP: $UBUNTU_IP, Poorten: $TOMCAT_PORT_HTTP, $TOMCAT_PORT_AJP" >>setup_log.txt
