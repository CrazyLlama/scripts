$DesktopPath = [Environment]::GetFolderPath("Desktop")

$url = @("http://www.kioptrix.com/dlvm/kiop2014.tar.bz2","https://download.vulnhub.com/skytower/SkyTower.zip","https://download.vulnhub.com/fristileaks/FristiLeaks_1.3.ova","https://download.vulnhub.com/stapler/Stapler.zip","https://download.vulnhub.com/vulnos/VulnOSv2.7z","https://download.vulnhub.com/sickos/sick0s1.2.zip","https://download.vulnhub.com/brainpan/Brainpan.zip","http://www.rebootuser.com/wp-content/uploads/vulnix/Vulnix.7z","https://download.vulnhub.com/devrandom/scream.exe","http://pwnos.com/files/pWnOS_v2.0.7z")
$output = @("$DesktopPath\VulnVMs\kiop2014.tar.bz2","$DesktopPath\VulnVMs\SkyTower.zip","$DesktopPath\VulnVMs\FristiLeaks_1.3.ova","$DesktopPath\VulnVMs\Stapler.zip","$DesktopPath\VulnVMs\VulnOSv2.7z","$DesktopPath\VulnVMs\sick0s1.2.zip","$DesktopPath\VulnVMs\Brainpan.zip","$DesktopPath\VulnVMs\Vulnix.7z","$DesktopPath\VulnVMs\scream.exe","$DesktopPath\VulnVMs\pWnOS_v2.0.7z")

$start_time = Get-Date

New-Item -ItemType directory -Path $DesktopPath\VulnVMs

ForEach ($VM in $VulnVMs) {

    Try {
    (New-Object System.Net.WebClient).DownloadFile($vm, $output)
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    } Catch {
    Add-Content Unavailable_VMs.txt
    }
}