function Download-Artifact()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$MetaFilePath,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$AppName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusServer,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusRepository,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactVersion,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$TargetPath
	)
	BEGIN { }
	
	PROCESS
	{   
	    # metadata file for that APP
        $appFile = Join-Path -Path $MetaFilePath -ChildPath "${AppName}.txt"
		
		# convert json data from metadata file to a PSCustomObject
	    $jsonObj = ConvertFrom-Json "$(Get-Content $appFile)"
		# convert PSCustomObject to HashTable
		$jsonHash = @{}
		foreach($property in $jsonObj.psobject.properties.name)
		{
			$jsonHash[$property] = $jsonObj.$property
		}
        
		# check ArtifactVersion ; if its LATEST , get latest version
		if( $ArtifactVersion.ToUpper() -eq "LATEST"){
			$ArtifactVersion = $jsonHash.$ArtifactName.latestVersion
		}
		
		# download the artifact
		$fileName = "${ArtifactName}.zip"     #eg. "artifactABC.zip" 
		$downloadFile = Join-Path -Path $TargetPath -ChildPath $fileName
		$urlDest = "{0}/repository/{1}/{2}/{3}/{4}/{5}" -f ($NexusServer, $NexusRepository, $AppName, $ArtifactName, $ArtifactVersion, $fileName)
		#$secpasswd = ConvertTo-SecureString $NexusPassword -AsPlainText -Force
		#$mycreds = New-Object System.Management.Automation.PSCredential ($NexusUsername, $secpasswd)
		
		# retry 3 times with 10 seconds intrval between retries
		$Stoploop = $False
		$Retrycount = [int]"1"
		do {
			try {
				Invoke-WebRequest -OutFile $downloadFile -Method Get -Uri $urlDest
				Write-Host "Job completed"
				$Stoploop = $true
			}
			catch {
				$exceptionMessage = $_.Exception.Message
				Write-Host "Failed to download '$urlDest': $exceptionMessage"
				if ($Retrycount -gt 3){
					Write-Host "Could not send Information after 3 retrys."
					$Stoploop = $true
				}
				else {
					Write-Host "Could not send Information retrying in 10 seconds..."
					Start-Sleep -Seconds 10
					$Retrycount = $Retrycount + 1
				}
			}
		}
		While ($Stoploop -eq $false)
		
		# update the metadata hashTable for APP 
		if ($jsonHash.$ArtifactName.currentVersion -ne $ArtifactVersion) {
			$jsonHash.$ArtifactName.previousVersion = $jsonHash.$ArtifactName.currentVersion
			$jsonHash.$ArtifactName.currentVersion = $ArtifactVersion
		}
		
		#save hashTable to metadata file
        $jsonNewObj = [pscustomobject]$jsonHash
		$jsonNewObj | ConvertTo-Json -depth 100 | Set-content -Path $appFile
	}
	END { }
}

Download-Artifact $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6]