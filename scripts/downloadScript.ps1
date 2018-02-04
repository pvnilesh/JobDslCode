function Download-Artifact()
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
        Write-OutPut $NexusServer
        $ArtifactVersion = $ArtifactVersion.ToUpper()
        IF ($ArtifactVersion -eq "LATEST")
        {

			Write-OutPut "version is latest"   

		}

		ELSE

		{

			Write-OutPut "version is ${ArtifactVersion}"        

		}
    		
	}
	END { }
}

Download-Artifact $args[0] $args[1] $args[2] $args[3] $args[4]