# my_deploy.pp
# 
# to deploy artifact to any app server
#
# 

class my_fetch_deploy::my_deploy (
   $deploy_to,
   $filename,
   $file_source,
) {
   
   # deploy to tomcat
   if $deploy_to == 'tomcat' and $facts['os']['family'] != 'windows' {
     tomcat::war { $filename:
	   catalina_base => '/opt/tomcat',
	   war_source    => $file_source,
	 }
   } elsif $deploy_to == 'tomcat' and $facts['os']['family'] == 'windows' {
     file { "${win_tomcat::catalina_home}\\webapps\\${filename}":
       ensure => file,
       source => $file_source,
     }
   }
   
}
