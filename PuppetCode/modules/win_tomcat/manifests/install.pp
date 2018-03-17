# win_tomcat::install
#
# This class installs Tomcat.  To specify a version change the values
# in the {modulepath}/data/common.yaml.  If version 7 or 9 it tells chocolatey
# to install with the whole version number otherwise it defaults to 'latest' version 8.
#
#
# @example
#   include win_tomcat::install
class win_tomcat::install {
  package { 'tomcat':
    ensure          => $win_tomcat::ensure,
    provider        => chocolatey,
    install_options => ['--version', "${win_tomcat::version}", '-params', '"', "unzipLocation=${win_tomcat::install_path}", '"'],
  }
}