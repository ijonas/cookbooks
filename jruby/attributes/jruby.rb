### PACKAGES
default[:jruby][:version]           = "1.5.6"
default[:jruby][:binaries_url]      = "http://jruby.org.s3.amazonaws.com/downloads/#{jruby[:version]}/jruby-bin-#{jruby[:version]}.tar.gz"
default[:jruby][:checksum]          = "fd3af01f8fbb443d9a30a3ea3b8054daddb1cb96"
default[:jruby][:home_dir]          = "/usr/local/lib/jruby-#{jruby[:version]}"
default[:jruby][:gems_dir]          = "#{jruby[:home_dir]}/lib/ruby/gems/1.8/gems"
