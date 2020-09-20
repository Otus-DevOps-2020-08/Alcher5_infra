#!/bin/bash

# install git
sudo apt install -y git

# Clone repository
git clone -b monolith https://github.com/express42/reddit.git

# Install requirements
cd reddit && bundle install

# Launch puma app
puma -d
