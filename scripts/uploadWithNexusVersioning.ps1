$arr = $env:SOURCE_FILE_PATH.split('\')
$fileName = $arr[-1]
$urlDest = "{0}/repository/{1}/{2}" -f ($env:NEXUS_SERVER, $env:NEXUS_REPOSITORY, $fileName)
$webClient = New-Object System.Net.WebClient
$webClient.Credentials = New-Object System.Net.NetworkCredential($env:NEXUS_USERNAME, $env:NEXUS_PASSWORD)
$webClient.UploadFile($urlDest, "PUT", $env:SOURCE_FILE_PATH)