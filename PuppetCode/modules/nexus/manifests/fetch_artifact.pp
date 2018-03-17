# fetch.pp
# Main class of nexus to fetch the artifatcs from Nexus Repository
#
# fetch maven artifact from Nexus Repository using the custom type 'nexus_artifact'
# Example - 
# class {"fetch_artifact":
#  nexus      => 'https://repository.sonatype.org/nexus'
#  username   => $username, # nexus username
#  password   => $password, # nexus password
#  id         => 'app-runner', # artifact id
#  repo       => 'central',    # nexus repo id
#  group      => "com.danielflower.apprunner", # nexus group
#  classifier => "",
#  ensure     => present,
#  version    => '1.1.1',
#  name       => 'apprunner',
#  extension  => 'jar',
#  owner      => 'apprunner',
#  path       => '/root',
#  mode       => '0644'
#}
# Parameters
### username ##
# username of nexus; eg admin
### password ##
# password of nexus; eg admin123 
### nexus ##
# nexus server URL; eg https://repository.sonatype.org/nexus  
### repo ##
# repository name; eg central
### group ##
# group id; eg com.danielflower.apprunner
### id ##
# artifact id; eg app-runner
### version ##
# artifact version; eg 1.0.1
### classifier ##
# artifact classifier; eg "\n"
### extension ##
# artifact extension; eg war
### name ##
# name of target artifact; eg apprunner
### path ## 
# path of target artifact; eg /var/tmp
### owner ##
# owner of target artifact; eg root
### mode ##
# mode of target artifact; eg 0644

class nexus::fetch_artifact (
  $username = 'admin',
  $password = 'admin123',
  $nexus,
  $repo,
  $group,
  $id,
  $version = 'latest',
  $classifier = '',
  $extension = 'war',
  $name,
  $path = '/var/tmp',
  $owner = 'root',
  $mode = '0644',
  $enusre = 'present',
) {  
  
  nexus_artifact { $name:
	nexus      => $nexus,
    username   => $username, 
    password   => $password,
    id         => $id,
    repo       => $repo,
    group      => $group,
    classifier => $classifier,
    ensure     => $ensure,
    version    => $version,
    name       => $name,
    extension  => $extension,
    owner      => $owner,
    path       => $path,
    mode       => $mode,
  }
}
