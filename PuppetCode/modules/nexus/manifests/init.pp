# == Class: nexus
# This class installs and configures Nexus.
#
#
# === Parameters
#
#
#
# === Examples
#
# * Installation:
#     class { 'nexus': }
#
#
# === Authors
#
#
#
class nexus(

) {

  #include ::java

  class { '::nexus::install': } ->
  class { '::nexus::config': } ~>
  class { '::nexus::service': }

}
