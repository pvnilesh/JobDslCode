function Import-ArtifactPOM()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusServer,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusRepository,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactVersion,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactExtension
	)
	BEGIN { }
	
	PROCESS
	{
        Write-Output $NexusServer
        $ArtifactVersion = $ArtifactVersion.ToUpper()
        IF ($ArtifactVersion -eq "LATEST")
        {

			Write-Host "version is latest"   

		}

		ELSE

		{

			Write-Host "version is ${ArtifactVersion}"        

		}
    		
	}
	END { }
}