#!/bin/bash

# Install apt https transport and ca-certs
sudo apt install -y apt-transport-https ca-certificates

# Get repository key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# Install Mondgodb
sudo apt update
sudo apt install -y mongodb-org

# Enable and start mongod servive
sudo systemctl start mongod
sudo systemctl enable mongod
