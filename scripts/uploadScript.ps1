$arr = $SOURCE_FILE_PATH.split('\')
$fileName = $arr[-1]
$urlDest = "{0}/repository/{1}/{2}" -f ($NEXUS_SERVER, $NEXUS_REPOSITORY, $fileName)
$webClient = New-Object System.Net.WebClient
$webClient.Credentials = New-Object System.Net.NetworkCredential($NEXUS_USERNAME, $NEXUS_PASSWORD)
$webClient.UploadFile($urlDest, "PUT", $SOURCE_FILE_PATH)