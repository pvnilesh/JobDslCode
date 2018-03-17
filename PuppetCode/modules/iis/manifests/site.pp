#
# Parameters
# Examples

class iis::site (
  $site_name,
  $ensure='present',
  $applicationpool='DefaultAppPool',
  $physicalpath,
  $port,
) {  
	iis_site { $site_name:
		ensure               => $ensure,
		applicationpool      => $applicationpool,
		physicalpath    => $physicalpath,
		enabledprotocols     => 'https',
		bindings             => [
			{
			'bindinginformation'   => "*:$port:",
			'protocol'             => 'http',
			},
		],
		require         => File['minimal'],
	}

	file { 'minimal':
		ensure => 'directory',
		path   => $physicalpath,
	}
}
