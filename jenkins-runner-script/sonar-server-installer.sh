#!/bin/bash
# prebuild
sudo apt-get update -y
sleep 30
sudo apt install openjdk-17-jdk-headless -y
#install Docker
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli docker-compose -y
sudo service docker enable
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Install Sonarqube server
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
