maintainer       "Ijonas Kisselbach"
maintainer_email "ijonas.kisselbach@t-systems.com"
license          "All rights reserved"
description      "Installs/Configures contentmigrator"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.2"

recipe "contentmigrator", "Installs Content Migrator into a preconfigured Tomcat instance"
recipe "contentmigrator::mysqldb", "Creates the database, table structure and admin user account for Content Migrator"

depends "tomcat"
depends "mongodb"
depends "jruby"
depends "mysql"