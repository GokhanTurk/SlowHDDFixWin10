$path = "$env:userprofile\AppData\Local\Google\Chrome\User` Data\SwReporter"
$contents = Get-ChildItem -Path $path -ErrorAction SilentlyContinue
$len = $contents.Length
for ($i=0;$i -le $len;$i++){
$fileName = $contents[$i].Name
icacls $path\$fileName\software_reporter_tool.exe /inheritance:r
}
