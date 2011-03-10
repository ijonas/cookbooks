#
# Cookbook Name:: contentmigrator
# Recipe:: default
#
# Copyright 2010, T-Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

# include_recipe "tomcat"
# include_recipe "mysql::server"
# include_recipe "mysql"
# include_recipe "mongodb::source"
# include_recipe "jruby"

package "unzip" do
  action :install
end

directory "/opt/downloads" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# create a folder to unzip the war file contents into 
directory "#{node[:tomcat][:base]}/webapps/vcm" do
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
  mode "0755"
  action :create
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

# create the database
template "/tmp/create_database.sql" do
  source "create_database.sql.erb"
  mode "0644"
end
cookbook_file "/tmp/create_schema.sql" do
  source "create_schema.sql" 
  mode "0644"
end
cookbook_file "/tmp/seed_schema.sql" do
  source "seed_schema.sql" 
  mode "0644"
end
template "#{node[:tomcat][:base]}/webapps/vcm/WEB-INF/config/database.yml" do
  source "database.yml.erb" 
  mode "0644"
  owner node[:tomcat][:user]
  group node[:tomcat][:group]
end
execute "create_database" do
  command "mysql -uroot -p#{node[:mysql][:server_root_password]} < /tmp/create_database.sql"
end
execute "create_schema" do
  command "mysql -u#{node[:contentmigrator][:mysql_username]} -p#{node[:contentmigrator][:mysql_password]} #{node[:contentmigrator][:mysql_database]} < /tmp/create_schema.sql"
end
execute "seed_schema" do
  command "mysql -u#{node[:contentmigrator][:mysql_username]} -p#{node[:contentmigrator][:mysql_password]} #{node[:contentmigrator][:mysql_database]} < /tmp/seed_schema.sql"
end
execute "install_rails_gems" do
  command "#{node[:jruby][:home_dir]}/bin/jruby -S gem install rails -v 2.3.3 --no-rdoc --no-ri"
  creates "#{node[:jruby][:gems_dir]}/rails-2.3.3/README"
end
