function Create-Sites()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$CreateSites,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$SiteFile
	)
	BEGIN { }
	
	PROCESS
	{   
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