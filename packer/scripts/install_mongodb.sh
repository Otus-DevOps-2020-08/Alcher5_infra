#!/bin/bash

# Install apt https transport and ca-certs
apt-get install -y apt-transport-https libcurl3-gnutls ca-certificates

# Get repository key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# Install Mondgodb
apt-get update
apt-get install -y mongodb-org

# Enable and start mongod servive
systemctl start mongod
systemctl enable mongod
