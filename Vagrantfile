# Vagrantfile to create an Centos7 VMs on Platform9 OpenStack
# After VM creation, we are executing linux commands to install Puppet enterprise server and starting puppet service.
# Author: Kunal Jadhav

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
    os.floating_ip_pool     = 'external'
    os.networks             = ['network1']
    os.security_groups      = ['default']
  end

  # KILL SMB WITH FIRE
  config.vm.allowed_synced_folder_types = [:rsync]

  config.vm.define 'PE-Server' do |s|
    s.vm.provider :openstack do |os, override|
      os.server_name = 'PE-Server'
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

  config.vm.define 'Nix-Agent-1' do |s|
    s.vm.provider :openstack do |os, override|
      os.server_name = 'Nix-Agent-1'
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