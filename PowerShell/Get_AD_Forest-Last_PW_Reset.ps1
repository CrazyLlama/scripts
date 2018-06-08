$domains = (Get-ADForest).Domains
$data = @()

foreach ($domain in $domains)
{
    $data += Get-ADComputer -Filter { OperatingSystem -Like '*Windows Server*' } -Server $domain -Properties LastLogonDate,PasswordLastSet,operatingsystem,CanonicalName | select Name,PasswordLastSet,operatingsystem,CanonicalName,LastLogonDate
}

$data | export-csv $DesktopPath = [Environment]::GetFolderPath("Desktop")\servercomputerrecords.csv -NoType
