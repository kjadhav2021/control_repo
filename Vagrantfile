# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
 # config.vm.box = "base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end

# Vagrantfile to create an Ubuntu VM on Platform9 OpenStack
# In our environment we have to boot from a new volume rather
# than booting directly from an image, hence the `volume_boot`
# config hash.

#export OS_AUTH_URL=https://puppet.platform9.net/keystone/v3
#export OS_IDENTITY_API_VERSION=3
#export OS_REGION_NAME="Portland"
#export OS_PROJECT_NAME="Kunal Jadhav"
#export OS_PROJECT_DOMAIN_ID=${OS_PROJECT_DOMAIN_ID:-"default"}
#export OS_USER_DOMAIN_ID=${OS_USER_DOMAIN_ID:-"default"}
#export OS_USERNAME="kunal.jadhav@puppet.com"
#export OS_PASSWORD="<password>"

#export OS_KEYPAIR_NAME="kj_platform9_ssh"
#export OS_SSH_KEY_PATH="${HOME}/sshkeys/cloud-key"

#echo "Please enter your OpenStack Password: "
#read -sr OS_PASSWORD_INPUT
#echo $OS_PASSWORD_INPUT
#export OS_PASSWORD=$OS_PASSWORD_INPUT
#export VAGRANT_DEFAULT_PROVIDER="openstack"

$script = <<SCRIPT
pwd
mkdir downloads
sudo su -
cd /home/centos/downloads
curl -JLo puppet-server.tar.gz 'https://pm.puppet.com/cgi-bin/download.cgi?dist=el&rel=7&arch=x86_64&ver=latest'
tar -xf puppet-server.tar.gz
cd puppet-e*
./puppet-enterprise-installer
puppet infrastructure console_password --password=admin
puppet agent -t
puppet agent -t
yum install git -y
SCRIPT

$script1 = <<SCRIPT
pwd
mkdir downloads
SCRIPT


Vagrant.configure("2") do |config|
  #config.ssh.username = 'centos'
  config.ssh.private_key_path = ENV['OS_SSH_KEY_PATH']
  config.ssh.insert_key = true
  config.vm.provider :openstack do |os|
    os.openstack_auth_url   = ENV['OS_AUTH_URL']
    os.identity_api_version = ENV['OS_IDENTITY_API_VERSION']
    os.username             = ENV['OS_USERNAME']
    os.password             = ENV['OS_PASSWORD']
    os.keypair_name         = ENV['OS_KEYPAIR_NAME']
    os.project_name         = ENV['OS_PROJECT_NAME']
    os.region               = ENV['OS_REGION_NAME']
    os.domain_name          = ENV['OS_PROJECT_DOMAIN_ID']
#    os.flavor               = 'm1.medium'
    os.floating_ip_pool     = 'external'
    os.networks             = ['network1']
    os.security_groups      = ['default']
#    os.server_name          = 'primary_server'
#    os.availability_zone    = 'nova'
#    os.volume_boot          = {
#      size:              20,
#      delete_on_destroy: true,
#      image:             'centos_7_x86_64',
#    }
  end

  # KILL SMB WITH FIRE
  config.vm.allowed_synced_folder_types = [:rsync]

  #config.vm.provision "shell" do |s|
  #  s.inline = $script
  #end

    config.vm.define 'server1' do |s|
    s.vm.provider :openstack do |os, override|
      os.server_name = 'primary-server'
      override.ssh.username = "centos"
      os.flavor = 'm1.large'
      os.volume_boot = {
      size: 40,
      delete_on_destroy: true,
      image: 'centos_7_x86_64',
    }
  end
  s.vm.provision :shell, inline: $script
  end

  config.vm.define 'server2' do |s|
    s.vm.provider :openstack do |os, override|
      os.server_name = 'agent-node1'
      override.ssh.username = "centos"
	    os.flavor = 'm1.medium'
      os.volume_boot = {
      size: 20,
      delete_on_destroy: true,
      image: 'centos_7_x86_64',
    }
    end
    s.vm.provision :shell, inline: $script1
  end

end
