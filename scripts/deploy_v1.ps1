function Deploy-()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$CreateAppPools,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$AppPoolFile,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$CreateSites,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$SiteFile
	)
	BEGIN { }
	
	PROCESS
	{   
	    if($CreateAppPools.ToUpper() -eq "TRUE"){
			$jsonObj = ConvertFrom-Json "$(Get-Content $AppPoolFile)"
			$jsonHash = @{}
			foreach($property in $jsonObj.psobject.properties.name)
			{
				$jsonHash[$property] = $jsonObj.$property
			}
	
			foreach($appPool in $jsonHash.AppPools){
				$str = "class {{'iis::app_pool': app_pool_name=>'{0}', ensure=>'{1}', state=>'{2}', managed_pipeline_mode=>'{3}', managed_runtime_version=>'{4}'}}" -f ($appPool.app_pool_name, $appPool.ensure, $appPool.state, $appPool.managed_pipeline_mode, $appPool.managed_runtime_version)
				puppet apply --modulepath ./PuppetCode/modules -e $str
			}
		} else {
			Write-Host "you confirmed not to create App Pools"
		}

		if($CreateSites.ToUpper() -eq "TRUE"){
			$jsonObj = ConvertFrom-Json "$(Get-Content $SiteFile)"
			$jsonHash = @{}
			foreach($property in $jsonObj.psobject.properties.name)
			{
				$jsonHash[$property] = $jsonObj.$property
			}
	
			foreach($site in $jsonHash.Sites){
				$str = "class {{'iis::site': site_name=>'{0}', ensure=>'{1}', applicationpool=>'{2}', physicalpath=>'{3}', port=>'{4}'}}" -f ($site.site_name, $site.ensure, $site.applicationpool, $site.physicalpath, $site.port)
				puppet apply --modulepath ./PuppetCode/modules -e $str
			}
		} else {
			Write-Host "you confirmed not to create sites"
		}		
	}
	END { }
}