#
# Cookbook Name:: webworxx
# Recipe:: default
#
# Copyright 2010, T-Systems
#
# All rights reserved - Do Not Redistribute
#


# Create the deploy user
# execute "create webapps group" do
#   command "groupadd webapps"
# end
# execute "create webapps user" do
#   command "useradd -m -s /bin/bash -g webapps -p Asomav1 webapps"
# end

# Create some top-level project folders
[node[:webworxx][:dir], node[:webworxx][:megatron_dir], "/home/webapps/.ssh"].each do |dir|
  directory dir do
    owner "webapps"
    group "webapps"
    mode 0755
    recursive true
    action :create
  end
end

# # Copy the deploy users keys for accessing github
# cookbook_file "/home/webapps/.ssh/id_rsa" do
#   source "chefclient_id_rsa" 
#   mode "0600"
# end
# cookbook_file "/home/webapps/.ssh/id_rsa.pub" do
#   source "chefclient_id_rsa.pub" 
#   mode "0600"
# end

# Ensure Github is a 'known' host
cookbook_file "/home/webapps/.ssh/known_hosts" do
  source "github_known_hosts" 
  mode "0644"
end

# Deploy WebWorxx code from git repo
git node[:webworxx][:dir] do
  repository "git@github.com:vamosa/cnf.git"
  reference "HEAD"
  user "webapps"
  group "webapps"
  action :sync
end

# deploy node[:webworxx][:dir] do
#   repo "git@github.com:vamosa/cnf.git"
#   revision "HEAD" # or "HEAD" or "TAG_for_1.0" or (subversion) "1234"
#   user "webapps"
#   enable_submodules true
#   migrate true
#   migration_command "rake db:migrate"
#   environment "RAILS_ENV" => "development", "RACK_ENV" => "development"
#   shallow_clone true
#   action :deploy # or :rollback
#   # restart_command "touch tmp/restart.txt"
#   # git_ssh_wrapper "wrap-ssh4git.sh"
#   scm_provider Chef::Provider::Git # is the default, for svn: Chef::Provider::Subversion
# end

# Deploy Megatron code from git repo
git node[:webworxx][:megatron_dir] do
  repository "git@github.com:vamosa/megatron.git"
  reference "HEAD"
  user "webapps"
  group "webapps"
  action :sync
end

# Configure database connection
# ruby_block "configure_database_connection" do
#   block do
#     require "yaml"
#     config = YAML.load_file("#{node[:webworxx][:dir]}/config/database.yml")
#     config['development']['database'] = node[:webworxx][:mysql_database]
#     config['development']['username'] = node[:webworxx][:mysql_username]
#     config['development']['password'] = node[:webworxx][:mysql_password]
#     File.open(filename, "w") {|f| YAML.dump(config, f)}
#   end
# end

# Create MySQL tableschema
template "/tmp/create_database.sql" do
  source "create_database.sql.erb"
end
cookbook_file "/tmp/create_schema.sql" do
  source "create_schema.sql" 
  mode "0644"
end
cookbook_file "/tmp/seed_schema.sql" do
  source "seed_schema.sql" 
  mode "0644"
end
template "#{node[:webworxx][:dir]}/config/database.yml" do
  source "database.yml.erb" 
  mode "0644"
end
execute "create_database" do
  command "mysql -uroot -p#{node[:mysql][:server_root_password]} < /tmp/create_database.sql"
end
execute "create_schema" do
  command "mysql -u#{node[:webworxx][:mysql_username]} -p#{node[:webworxx][:mysql_password]} #{node[:webworxx][:mysql_database]} < /tmp/create_schema.sql"
end
execute "seed_schema" do
  command "mysql -u#{node[:webworxx][:mysql_username]} -p#{node[:webworxx][:mysql_password]} #{node[:webworxx][:mysql_database]} < /tmp/seed_schema.sql"
end

# install libs for gem dependencies
%w(libcurl4-gnutls-dev libxml2 libxml2-dev libxslt1-dev).each do |package_name|
  package package_name do
    action :install
  end
end
execute "gem_install_bundler" do
  command "#{node[:ruby_enterprise][:install_path]}/bin/gem install bundler"
end
execute "bundle_install" do
  command "#{node[:ruby_enterprise][:install_path]}/bin/bundle install"
  cwd node[:webworxx][:dir]
end

# Setup the default site on nginx
template "/etc/nginx/sites-available/default" do
  source "sites_available_default.erb"
end
link "/etc/nginx/sites-enabled/default" do
  to "/etc/nginx/sites-available/default"
end

