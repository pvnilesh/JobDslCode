# == Class: artifactory::service
#
# This class manages the artifactory service.  It should not be called directly
#
#
# === Authors
#
# * Jainish Shah <mailto:jainishs@jfrog.com>
#
class artifactory::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'artifactory':
    ensure   => running,
    name     => $::artifactory::service_name,
    enable   => true,
    provider => redhat,
    require  => Class['java'],
  }

}
