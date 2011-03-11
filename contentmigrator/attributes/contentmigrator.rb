default[:contentmigrator][:version]           = "3.0.1-beta1-mysql"
default[:contentmigrator][:binaries_url]      = "https://s3-eu-west-1.amazonaws.com/vam-downloads/ContentMigrator-#{contentmigrator[:version]}.war"
default[:contentmigrator][:checksum]          = "43903da5bef53640bbd8ff706963c3fc5e1b5f03"                                                 
default[:contentmigrator][:tasklib_home]      = "/opt/vcm_tasklib"

default[:contentmigrator][:mysql_host]       = "localhost"
default[:contentmigrator][:mysql_username]   = "vamosa"
default[:contentmigrator][:mysql_password]   = "vcm"
default[:contentmigrator][:mysql_database]   = "vcm"


