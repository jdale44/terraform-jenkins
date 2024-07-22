#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sleep 30
sudo apt install openjdk-17-jdk-headless -y
sudo apt install maven -y
sudo apt install docker.io -y
sudo groupadd docker
group 'docker' already exists
sudo usermod -aG docker $USER
newgrp docker
#install trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
sudo apt update
sudo apt install snapd
sudo snap install trivy
sleep 60
# reboot for docker permissions
sudo init 6