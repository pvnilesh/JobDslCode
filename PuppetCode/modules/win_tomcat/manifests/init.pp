# win_tomcat
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include win_tomcat
class win_tomcat (
  $version,
  $install_path,
  $ensure,
  $service_name,
  $tcusersxml,
  $catalinapolicy,
  $contextxml,
  $loggingproperties,
  $serverxml,
  $webxml,
  $catalinaproperties,
  $sample_app_src,
  $catalina_home,
) {
  include win_tomcat::install
  include win_tomcat::config
  include win_tomcat::service
  include win_tomcat::webapps

  Class['win_tomcat::install']
  -> Class['win_tomcat::config']
  ~> Class['win_tomcat::service'] # the ~> "notifies" the service when a change happens.
}
