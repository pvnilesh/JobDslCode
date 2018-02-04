function Download-Artifact()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusServer,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusRepository,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactVersion,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactExtension,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$TargetPath
	)
	BEGIN { }
	
	PROCESS
	{
        If(!(test-path $TargetPath))
		{
			  New-Item -ItemType Directory -Path $TargetPath
		}

        $ArtifactVersion = $ArtifactVersion.ToUpper()
        IF ($ArtifactVersion -eq "LATEST")
        {  
			$metaFile = "..\artifactMetaData\artifactDetails.txt"
			$jsonFile = ConvertFrom-Json "$(Get-Content $metaFile)"
			$ArtifactVersion = $jsonFile.$ArtifactName.LatestVersion
		}

		ELSE
		{   

		}
		
		$fileName = "{0}-{1}.{2}" -f ($ArtifactName, $ArtifactVersion, $ArtifactExtension)		
		$urlDest = "{0}/repository/{1}/{2}" -f ($NexusServer, $NexusRepository, $fileName)
		$taretFile = "{0}\{1}.{2}" -f ($TargetPath, $ArtifactName, $ArtifactExtension)
		$webClient = New-Object System.Net.WebClient
		$webClient.DownloadFile($urlDest, $taretFile)
		    		
	}
	END { }
}

Download-Artifact $args[0] $args[1] $args[2] $args[3] $args[4] $args[5]