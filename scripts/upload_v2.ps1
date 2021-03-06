function Upload-Artifact()
{
	[CmdletBinding()]
	param
	(
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$MetaFilePath,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$AppName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactName,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusServer,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusRepository,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusUsername,
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$NexusPassword,		
		[string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$ArtifactFilePath,
		[string]$ArtifactServer,
		[string]$ArtifactServerUser,
		[string]$ArtifactServerPassword
	)
	BEGIN { }
	
	PROCESS
	{   
	    # check if metadata file for that APP is present
		# if absent ; create it
		$metaFile = "${AppName}.txt"
		$urlMeta = "{0}/repository/{1}/{2}/{3}" -f ($NexusServer, $NexusRepository, $MetaFilePath, $metaFile)
		
		# added retry logic
		$Stoploop = $False
		$Retrycount = [int]"1"
		do {
			try
			{
				$Response = Invoke-WebRequest -OutFile $metaFile -Method Get -Uri $urlMeta
				$Stoploop = $true
			}
			catch
			{
			    $exceptionMessage = $_.Exception.Message
				Write-Host "Failed to download '$urlMeta': $exceptionMessage"
				$Failure = $_.Exception.Response
				$statusCode = [string]$Failure.StatusCode
				if($statusCode.ToUpper() -eq "NOTFOUND"){
					$tempCustomObj = [pscustomobject]@{}
					$tempCustomObj | ConvertTo-Json -depth 10 | Set-content $metaFile
					$Stoploop = $true
				} ElseIf ($Retrycount -gt 3){
					Write-Host "Could not send Information after 3 retrys."
					$Stoploop = $true
				} else {
					Write-Host "Could not send Information retrying in 10 seconds..."
					Start-Sleep -Seconds 10
					$Retrycount = $Retrycount + 1
				}
			}
		}
		While ($Stoploop -eq $false)
		
		# convert json data from metadata file to a PSCustomObject
	    $jsonObj = ConvertFrom-Json "$(Get-Content $metaFile)"
		# convert PSCustomObject to HashTable
		$jsonHash = @{}
		foreach($property in $jsonObj.psobject.properties.name)
		{
			$jsonHash[$property] = $jsonObj.$property
		}

		# if ,artifact is absent in metadata file; add it
		# else, increment the latestVersion of that artifact
		if(!($jsonHash.Contains($ArtifactName)))
		{
			$tempObject = [PSCustomObject]@{
				currentVersion = '0.0'
				latestVersion = '1.0'
				previousVersion = '0.0'
                versions = @('1.0')				
			}
			$jsonHash.Add($ArtifactName, $tempObject)
		}
		else
		{
			$tempVar = [version]$jsonHash.$ArtifactName.latestVersion
			$tempVarStr = "{0}.{1}" -f ($tempVar.Major,($tempVar.Minor+1))
			$jsonHash.$ArtifactName.latestVersion = $tempVarStr
			$jsonHash.$ArtifactName.versions += $tempVarStr
		}
		
		# get latestVersion of the artifact
		$latestVer = $jsonHash.$ArtifactName.latestVersion
		
        # upload the artifact
		$fileName = "${ArtifactName}.zip"     #eg. "artifactABC.zip" 
		$uploadFile = Join-Path -Path $ArtifactFilePath -ChildPath $fileName
		$urlDest = "{0}/repository/{1}/{2}/{3}/{4}/{5}" -f ($NexusServer, $NexusRepository, $AppName, $ArtifactName, $latestVer, $fileName)
	    $secpasswd = ConvertTo-SecureString $NexusPassword -AsPlainText -Force
		$mycreds = New-Object System.Management.Automation.PSCredential ($NexusUsername, $secpasswd)
		

		# retry 3 times with 10 seconds intrval between retries
		$Stoploop = $False
		$Retrycount = [int]"1"
		do {
			try {
				# upload artifact
				Invoke-WebRequest -InFile $uploadFile -Method Put -Uri $urlDest -Verbose -Credential $mycreds
				Write-Host "Job completed"
				$Stoploop = $true
				#save hashTable to metadata file
				$jsonNewObj = [pscustomobject]$jsonHash
				$jsonNewObj | ConvertTo-Json -depth 100 | Set-content -Path $metaFile
				# upload metadata file 
				Invoke-WebRequest -InFile $metaFile -Method Put -Uri $urlMeta -Verbose -Credential $mycreds
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
		
	}
	END { }
}

Upload-Artifact $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]