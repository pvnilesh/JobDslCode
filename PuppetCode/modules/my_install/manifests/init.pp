# init.pp
# Main class of software
#
# install any software 
# To install software with latest version using OS's package manager
# specify $install_from='package_manager' and $app_name

class my_install (
  $app_name,
) {

  #$software_ensure = 'latest'
  
  include chocolatey
  
    case $::osfamily {
      'debian': {
        package { "$app_name":
          ensure   => 'latest',
          provider => apt,
        }
      }
	  'redhat': {
        package { "$app_name":
          ensure   => 'latest',
          provider => yum,
        }
      }
      'windows': {
        package { "$app_name":
          ensure   => 'latest',
          provider => chocolatey,
        }
      }
      default: {
        fail("The ${app_name} app is not present in package manager on ${::operatingsystem} for default installation of latest version using package manager.")
      }
    }
  
  
}
