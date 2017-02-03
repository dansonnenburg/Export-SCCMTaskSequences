param (
    $SiteCode
    $SiteServer
    $ExportDir
)
# Export Task Sequences
Push-Location $ExportDir
Get-WmiObject SMS_TaskSequencePackage -Namespace root\sms\site_$SiteCode -ComputerName $SiteServer
ForEach ($Ts in $TsList)
{
    $Ts = [wmi]"$($Ts.__PATH)"
    $filename = "$($ts.Name) {0:yyyyMMdd-HHmm}.xml" -f (Get-Date)
    Set-Content -Path $filename -Value $Ts.Sequence
}
Pop-Location
