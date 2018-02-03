Set-Location "${ENV:WORKSPACE}\artifact_code"
$metaFile = "metadata.txt"
$jsonFile = ConvertFrom-Json "$(Get-Content $metaFile)"
$artifactName = $jsonFile.Name
$artifactVersion = $jsonFile.Version

$targetPath = "C:\Jenkins\target"
If(!(test-path $targetPath))
{
      New-Item -ItemType Directory -Path $targetPath
}


$srcFile = "${artifactName}.txt"
$OutFile = "${artifactName}-${artifactVersion}.zip"
$targetFile = "$(Join-Path $targetPath $outFile)"
if (!(Test-Path $targetFile))
{
   Compress-Archive -Path $srcFile -DestinationPath $targetFile
}