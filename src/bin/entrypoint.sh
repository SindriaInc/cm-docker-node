#!/usr/bin/env bash

set -e

# Infra setup
#mkdir -p .setup
#cd .setup
#git clone https://${IAC_GIT_USERNAME}:${IAC_GIT_PASSWORD}@${IAC_GIT_PROVIDER}/${IAC_GIT_NAMESPACE}/${IAC_INFRA_NAME}.git
#cp ${IAC_INFRA_NAME}/config/* ../config

# Setup ssh private key
mkdir -p /root/.ssh
(umask 077; echo ${IAC_PRIVATE_KEY} | base64 -d > /root/.ssh/sindria@cm)
chmod 700 /root/.ssh
chmod 600 /root/.ssh/*

# Init inventory
mkdir -p inventory

# Sync inventory - Dowload
aws s3 sync s3://${IAC_INVENTORY_CACHE} ./inventory

# Dry run playboook
#ansible-playbook main.yml --check

# Run playbook
ansible-playbook main.yml