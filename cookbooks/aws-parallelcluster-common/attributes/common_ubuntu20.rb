# Ubuntu 20 common attributes shared between multiple cookbooks

return unless platform?('ubuntu') && node['platform_version'] == "20.04"

# Modulefile Directory
default['cluster']['modulefile_dir'] = "/usr/share/modules/modulefiles"
# MODULESHOME
default['cluster']['moduleshome'] = "/usr/share/modules"
# Config file used to set default MODULEPATH list
default['cluster']['modulepath_config_file'] = "#{node['cluster']['moduleshome']}/init/.modulespath"

default['cluster']['chrony']['service'] = "chrony"
