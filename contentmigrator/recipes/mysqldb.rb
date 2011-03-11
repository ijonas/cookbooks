#
# Cookbook Name:: contentmigrator
# Recipe:: mysqldb
#
# Copyright 2010, T-Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"
include_recipe "mysql"

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
execute "create_database" do
  command "mysql -uroot -p#{node[:mysql][:server_root_password]} < /tmp/create_database.sql"
end
execute "create_schema" do
  command "mysql -u#{node[:contentmigrator][:mysql_username]} -p#{node[:contentmigrator][:mysql_password]} #{node[:contentmigrator][:mysql_database]} < /tmp/create_schema.sql"
end
execute "seed_schema" do
  command "mysql -u#{node[:contentmigrator][:mysql_username]} -p#{node[:contentmigrator][:mysql_password]} #{node[:contentmigrator][:mysql_database]} < /tmp/seed_schema.sql"
end