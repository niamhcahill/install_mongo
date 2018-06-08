#
# Cookbook:: install_mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#If it doesn't exist, create the repo file to control mongodb install. This should be a template. Set appropriate permissions for repo file.
file '/etc/yum.repos.d/mongodb-org-3.6.repo' do
content '[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=0
enabled=1'
  mode '0644'
  owner 'root'
  group 'root'
end

#Install appropriate semanage utilities assuming CentOS is running in restricted mode
yum_package 'policycoreutils-python' do
	action :install
end

#Install Mongo DB
yum_package 'mongodb-org' do
	action :install
end

#Check that Port 27017 is allowed for Mongo DB assuming default Mongo configuration
bash 'open_port' do
cwd '/tmp'
code <<-EOH
semanage port -a -t mongod_port_t -p tcp 27017
EOH
returns [0, 1]
end

#Enable and start the Mongo service
service 'mongod' do
  action [:enable, :start]
end
