maintainer       "T-Systems Ltd."
maintainer_email "ijonas.kisselbach@t-systems.com"
license          "All rights reserved"
description      "Installs/Configures WebWorxx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends          "build-essential"
depends          "runit"
depends          "mongodb"
depends          "redis"
depends          "mysql"
depends          "nginx"
depends          "openssl"
depends          "passenger_enterprise"

recipe "webworxx", "Installs webworxx and megatron"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute "webworxx/dir",
  :display_name => "Webworxx Deploy Directory",
  :description => "Top level folder of WebWorxx code, sometimes called the project folder.",
  :default => "/home/webapps/webworxx"

attribute "webworxx/megatron_dir",
  :display_name => "Megatron Deploy Directory",
  :description => "Top level folder of Megatron code.",
  :default => "/home/webapps/megatron"

attribute "webworxx/mysql_username",
  :display_name => "WebWorxx Application MySQL Username",
  :description => "MySQL user account used by WebWorxx.",
  :default => "wwxx_dev"

attribute "webworxx/mysql_password",
  :display_name => "WebWorxx Application MySQL Password",
  :description => "MySQL password used by WebWorxx.",
  :default => "wwxx_dev"

attribute "webworxx/mysql_database",
  :display_name => "WebWorxx MySQL Database",
  :description => "MySQL database used by WebWorxx.",
  :default => "wwxx_dev"