#
# Cookbook Name:: contentmigrator
# Recipe:: default
#
# Copyright 2010, T-Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tomcat"
include_recipe "mongodb::source"
include_recipe "jruby"

package "unzip" do
  action :install
end

package "git-core" do
  action :install
end

directory "/opt/downloads" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

directory node[:contentmigrator][:tasklib_home] do
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
  mode "0755"
  action :create
  recursive true
end

# create a folder to unzip the war file contents into 
directory "#{node[:tomcat][:base]}/webapps/vcm" do
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
  mode "0755"
  action :create
  recursive true
end

# download the WAR file
remote_file "/opt/downloads/vcm.war" do
  source node[:contentmigrator][:binaries_url]
  checksum node[:contentmigrator][:checksum]
  action :create_if_missing
end

# uncompress war file
execute "uncompress_war_file" do
  command "unzip /opt/downloads/vcm.war -d #{node[:tomcat][:base]}/webapps/vcm"
end

execute "set webapps perms" do
  command "chown -R #{node[:tomcat][:user]}.#{node[:tomcat][:group]} #{node[:tomcat][:base]}"
end

# create vamosa-runtime.properties
template "#{node[:tomcat][:home]}/vamosa-runtime.properties" do
  source "vamosa-runtime.properties.erb"
  owner node[:tomcat][:user]
  group node[:tomcat][:group]  
end

template "#{node[:tomcat][:base]}/webapps/vcm/WEB-INF/config/database.yml" do
  source "database.yml.erb" 
  mode "0644"
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end
execute "install_rails_gems" do
  command "#{node[:jruby][:home_dir]}/bin/jruby -S gem install rails -v 2.3.3 --no-rdoc --no-ri"
  creates "#{node[:jruby][:gems_dir]}/rails-2.3.3/README"
end

git "#{node[:contentmigrator][:tasklib_home]}/Default Task Library" do
  repository "git://github.com/vamosa/VCM-Default-Tasks.git"
  reference "master"
  action :sync
  user node[:tomcat][:user]
  group node[:tomcat][:group]  
end
