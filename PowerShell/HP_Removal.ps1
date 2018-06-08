<#
.SYNOPSIS
  Uninstall HP Data Protector if it exists
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.2
  Author:         Brett Calderbank
  Creation Date:  30/05/2018
  Purpose/Change: Simplification for testing
  
.EXAMPLE
  ./HP_Removal.ps1 - run script
#>

"Removing:"
"HP Data Protector"

$app = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -match "HP Data" 
}

$app.Uninstall()

"Done!"

"Testing removal..."

$app_test = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -match "HP Data" 
}

If ($app_test -contains "name") {
    "Unsuccessfully removed"
    Start-Sleep -s 5
} else {
    "Successfully removed"
    Start-Sleep -s 5
}
