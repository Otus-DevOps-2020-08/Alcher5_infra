#!/bin/bash
set -e

PACKER_VERSION=1.6.2
TERRAFORM_VERSION=0.12.8
TFLINT_VERSION=0.20.3
ANSIBLE=2.6
ANSIBLE_LINT_VERSION=3.5.0


curl -L -o packer.zip "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
unzip -d ~/bin packer.zip
packer version
rm packer.zip

curl -L -o terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip -d ~/bin terraform.zip
terraform --version
rm terraform.zip

curl -L "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" -o tflint.zip
unzip -d ~/bin tflint.zip
~/bin/tflint --version
rm tflint.zip

sudo apt-get update
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

sudo pip install ansible==${ANSIBLE}

sudo pip install ansible-lint==${ANSIBLE_LINT_VERSION}
ansible-lint --version
