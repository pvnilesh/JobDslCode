# win_tomcat::webapps
#
# Deploy Tomcat applications from this class
#
# @summary Deploy your WAR files here.
#
# @example
#   include win_tomcat::webapps
class win_tomcat::webapps {
  # Sample Web Application, using Hiera data for param and value
  # Double slashes for Windows path
  file { "${win_tomcat::catalina_home}\\webapps\\sample.war":
    ensure => file,
    source => $win_tomcat::sample_app_src,
  }
  # Sample Web Application, using a direct URL
  #file { "${win_tomcat::catalina_home}\\webapps\\sample_apcera.war":
  #  ensure => file,
  #  source => 'https://github.com/apcera/sample-apps/raw/master/example-java-war/sample.war',
  #}
}
