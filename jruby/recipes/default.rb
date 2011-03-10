#
# Cookbook Name:: jruby
# Recipe:: default
#
# Copyright 2010, T-Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

case node.platform
when "centos","redhat","fedora"
  include_recipe "jpackage"
end

directory "/opt/downloads" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "/opt/downloads/jruby-bin-#{node[:jruby][:version]}.tar.gz" do
  source node[:jruby][:binaries_url]
  checksum node[:jruby][:checksum]
  action :create_if_missing
end

execute "unarchive_jruby" do
  command "tar -xf /opt/downloads/jruby-bin-#{node[:jruby][:version]}.tar.gz -C /usr/local/lib"
  creates "#{node[:jruby][:home_dir]}/bin/jruby"
end

ruby_block "setup_jruby_environment" do
  block do
    unless IO.read("/etc/profile") =~ /export JRUBY_HOME/
      open('/etc/profile', 'a') { |f|
        f.puts "export JRUBY_HOME=#{node[:jruby][:home_dir]}"
        f.puts "export PATH=$PATH:$JRUBY_HOME/bin"
      }
    end
  end
  action :create
end
