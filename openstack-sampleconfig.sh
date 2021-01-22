#!/bin/bash

export OS_AUTH_URL=https://<organisation auth url>
export OS_IDENTITY_API_VERSION=<api version>
export OS_REGION_NAME=<region name>
export OS_PROJECT_NAME=<project name>
export OS_PROJECT_DOMAIN_ID=${OS_PROJECT_DOMAIN_ID:-"default"}
export OS_USER_DOMAIN_ID=${OS_USER_DOMAIN_ID:-"default"}
export OS_USERNAME=<username>
#export OS_PASSWORD="<password>"

export OS_KEYPAIR_NAME=<ssh key pair name>
export OS_SSH_KEY_PATH=<ssh private key path>

echo "Please enter your OpenStack Password: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT
export VAGRANT_DEFAULT_PROVIDER="openstack"
