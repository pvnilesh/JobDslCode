# win_tomcat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include win_tomcat::config
class win_tomcat::config {
  include win_tomcat
  file { $win_tomcat::catalinaproperties:
    ensure  => file,
    content => epp('win_tomcat/catalina.properties.epp'),
    #basic template file that comes with default install.
    #Customization is coming soon
  }
  # Manage the tomcat-users.xml file.  Based on Puppet template.
  file { $win_tomcat::tcusersxml:
    ensure  => file,
    content => epp('win_tomcat/tomcat-users.xml.epp'),
  }
  # Manage the catalina.properties file.  Based on Puppet template.
  # Security policy permissions for Tomcat
  file { $win_tomcat::catalinapolicy:
    ensure  => file,
    content => epp('win_tomcat/catalina.policy.epp'),
  }
  # Manage the context.xml file.  Based on Puppet template.
  #  
  file { $win_tomcat::contextxml:
    ensure  => file,
    content => epp ('win_tomcat/context.xml.epp'),
  }
  # Manage the logging.properties file.  Based on Puppet template.
  # 
  file { $win_tomcat::loggingproperties:
    ensure  => file,
    content => epp('win_tomcat/logging.properties.epp'),
  }
  # Manage the server.xml file.  Based on Puppet template. 
  #
  file { $win_tomcat::serverxml:
    ensure  => file,
    content => epp('win_tomcat/server.xml.epp'),
  }
  # Manage the server.xml file.  Based on Puppet template. 
  # 
  file { $win_tomcat::webxml:
    ensure  => file,
    content => epp('win_tomcat/web.xml.epp'),
  }
}
