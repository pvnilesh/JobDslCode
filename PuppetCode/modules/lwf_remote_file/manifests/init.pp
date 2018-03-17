# == Class: lwf_remote_file
# This class for downloading file from remote server
#
#
# === Parameters
#
# === Examples
#
# === Authors
#
class lwf_remote_file(
  $ensure = 'present',
  $path,
  $source,
) {
   
  remote_file { $path:
    ensure => $ensure,
    path   => $path, 
    source => $source, 
  }
}
