# to deploy war file to taomcat root folder on windows

class win_tomcat::deploy (
  $catalina_home,
  $fileName,
  $sourceDir,
) {
  file { "${catalina_home}\\webapps\\${fileName}":
    ensure => file,
    source => "${sourceDir}\\${fileName}",
  }
}
