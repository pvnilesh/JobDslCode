class my_install::install_app (
  $app_name,
  $app_version,
  Optional[String] $app_ensure,
  Optional[String] $app_service_name,
  Optional[String] $app_user,
  Optional[String] $app_group,
) {
   
   # install tomcat
   if $app_name == 'tomcat' {
     $array_version = split($app_version, '[.]')
	 $maj_version = $array_version[0]
	 
	 # for Linux OS, using aco/tomcat module
	 if $facts['os']['family'] != 'windows' {
	   $package_url = http://archive.apache.org/dist/tomcat/tomcat-${maj_version}/v${app_version}/bin/apache-tomcat-${app_version}.tar.gz
	 
	   tomcat::install { '/opt/tomcat': 
	     source_url => $package_url,
	   }
	 
	   tomcat::instance { 'default':
	     catalina_home => '/opt/tomcat',
	   }
	 } 
	 # for Windows OS
	 else {
	   class { 'win_tomcat':
	     $version => $app_version,
	     $service_name => $app_service_name,
	   }
	 }     
   } 
   
}
