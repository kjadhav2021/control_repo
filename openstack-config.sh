#!/bin/bash

export OS_AUTH_URL=https://puppet.platform9.net/keystone/v3
export OS_IDENTITY_API_VERSION=3
export OS_REGION_NAME="Portland"
export OS_PROJECT_NAME="Kunal Jadhav"
export OS_PROJECT_DOMAIN_ID=${OS_PROJECT_DOMAIN_ID:-"default"}
export OS_USER_DOMAIN_ID=${OS_USER_DOMAIN_ID:-"default"}
export OS_USERNAME="kunal.jadhav@puppet.com"
#export OS_PASSWORD="<password>"

export OS_KEYPAIR_NAME="kj_platform9_ssh"
export OS_SSH_KEY_PATH="${HOME}/sshkeys/cloud-key"

echo "Please enter your OpenStack Password: "
read -sr OS_PASSWORD_INPUT
echo $OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT
export VAGRANT_DEFAULT_PROVIDER="openstack"