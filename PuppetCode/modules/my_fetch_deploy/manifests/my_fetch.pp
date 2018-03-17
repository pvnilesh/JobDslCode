# my_fetch.pp
#
# To fetch artifact from any artifact repository
#
# Parameters are - 
# common to Nexus,Artifactory => 
# exclusive to Nexus =>
# exclusive to Artifactory

class my_fetch_deploy::my_fetch (
  $fetch_from,
  Optional[String] $username,
  Optional[String] $password,
  $artifact_server_url,
  Optional[String] $artifact_repo_name,
  Optional[String] $artifact_group,
  Optional[String] $artifact_id,
  Optional[String] $artifact_version,
  Optional[String] $artifact_classifier,
  Optional[String] $artifact_extension,
  $target_artifact_name,
  $target_artifact_path,
  Optional[String] $target_artifact_owner,
  Optional[String] $target_artifact_mode,
  $ensure = 'present',
  Optional[String] $extra_path,
) {
   
   # fetch from Nexus
   if $fetch_from == 'nexus' {
	   class { 'nexus::fetch_artifact':
			 username   => $username,
			 password   => $password,
			 nexus      => $artifact_server_url,
			 repo       => $artifact_repo_name,
			 group      => $artifact_group,
			 id         => $artifact_id,
			 version    => $artifact_version,
			 classifier =>	$artifact_classifier,
			 extension  => $artifact_extension,
			 name       => $target_artifact_name,
			 path       => $target_artifact_path,
			 owner      => $target_artifact_owner,
			 mode       => $target_artifact_mode,
			 ensure     => $ensure,	 
	   }
   }
   
   # fetch from Artifactory
   #include artifactory::fetch_artifact
   if $fetch_from == 'artifactory' {
	   Artifactory::Fetch_artifact { 'fetch':
			 project => $artifact_id,
			 version => $artifact_version,
			 install_path => $target_artifact_path,
			 format => $artifact_extension,
			 path   => $extra_path,
			 server => $artifact_server_url,
			 repo => $artifact_repo_name,
			 filename => $target_artifact_name,
	   }
   }
   
   # fetch file from non-package based remote server; using lwf_remote_file module
   if $fetch_from = 'remote' {
     class { 'lwf_remote_file':
	   name        => $target_artifact_name,
	   ensure_file => $ensure,
	   target_path => $target_artifact_path,
	   source_path => $artifact_server_url,
	 }
   }
}
