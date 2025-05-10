#!/bin/bash

# Variabelen
IMAGE_NAME="ghostcat-tomcat"
CONTAINER_NAME="ghostcat"
TOMCAT_PORT_HTTP=8080
TOMCAT_PORT_AJP=8009
CURRENT_USER=$(whoami)
WORKDIR="$HOME/ghostcat"

# Automatisch het IP-adres ophalen (eerste niet-loopback IPv4-adres)
UBUNTU_IP=$(ip -4 addr show | grep -v '127.0.0.1' | grep -oP 'inet \K[\d.]+' | head -n 1)
if [ -z "$UBUNTU_IP" ]; then
    echo "Fout: Kon geen IP-adres detecteren. Controleer de netwerkconfiguratie."
    exit 1
fi
echo "Gedetecteerd IP-adres: $UBUNTU_IP"

# Maak werkmap aan
mkdir -p "$WORKDIR"
cd "$WORKDIR" || exit 1

# Controleer of Docker is geïnstalleerd
if ! command -v docker &> /dev/null; then
    echo "Docker is niet geïnstalleerd. Installeren..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker is al geïnstalleerd."
fi

# Voeg huidige gebruiker toe aan docker-groep
if ! groups "$CURRENT_USER" | grep -q docker; then
    echo "Toevoegen van $CURRENT_USER aan docker-groep..."
    sudo usermod -aG docker "$CURRENT_USER"
    # Forceer groepswijziging in huidige sessie
    newgrp docker << EOF
    echo "Gebruiker toegevoegd aan docker-groep."
EOF
else
    echo "$CURRENT_USER is al lid van de docker-groep."
fi

# Controleer of de Dockerfile bestaat
if [ ! -f "Dockerfile" ]; then
    echo "Fout: Dockerfile niet gevonden in $WORKDIR."
    exit 1
fi

# Bouw de Docker-image
echo "Bouwen van de Docker-image..."
docker build -t "$IMAGE_NAME" .

# Controleer of de container al draait, zo ja, stop en verwijder deze
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
    exit 1
fi

# Scan de poorten
if command -v nmap &> /dev/null; then
    echo "Scannen van poorten $TOMCAT_PORT_HTTP en $TOMCAT_PORT_AJP..."
    nmap "$UBUNTU_IP" -p "$TOMCAT_PORT_HTTP,$TOMCAT_PORT_AJP"
else
    echo "Nmap niet geïnstalleerd. Installeer met: sudo apt install nmap (optioneel)."
fi

# Schrijf een log voor reproduceerbaarheid
echo "Setup voltooid op $(date). Container: $CONTAINER_NAME, IP: $UBUNTU_IP, Poorten: $TOMCAT_PORT_HTTP, $TOMCAT_PORT_AJP" >> setup_log.txt