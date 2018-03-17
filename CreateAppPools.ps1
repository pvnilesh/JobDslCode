function Create-AppPools()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$CreateAppPools,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$AppPoolFile
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
	}
	END { }
}