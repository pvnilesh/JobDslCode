class mytomcat {
  include chocolatey
  
  package { 'tomcat':
    ensure   => latest,
    provider => 'chocolatey',
  }
}