$SiteCode = "CM1"
$ComputerName = "localhost"
$ExportDir = "\\<ServerName>\ExportedTaskSequences"

# List Task Sequences
$TsList = Get-WmiObject SMS_TaskSequencePackage -Namespace root\sms\site_$SiteCode -ComputerName $ComputerName| Select *
$TsList

# Export Task Sequences
cd C:
cd $ExportDir
#$TsList = Get-WmiObject SMS_TaskSequencePackage
Get-WmiObject SMS_TaskSequencePackage -Namespace root\sms\site_$SiteCode -ComputerName $ComputerName
ForEach ($Ts in $TsList)
{
    $Ts = [wmi]"$($Ts.__PATH)"
    $filename = "$($ts.Name) {0:yyyyMMdd-HHmm}.xml" -f (Get-Date)
    Set-Content -Path $filename -Value $Ts.Sequence
}