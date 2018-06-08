<#
.SYNOPSIS
  Uninstall HP Data Protector or EMC NetWorker if they exist
.INPUTS
  Paths for both:
   # HP Data Protector
   # EMC NetWorker
.OUTPUTS
  Console output - Currently
.NOTES
  Version:        1.0
  Author:         Brett Calderbank
  Creation Date:  24/05/2018
  Purpose/Change: Initial script development
  
.EXAMPLE
  ./EMC_HP.ps1 - run script
#>
$EMC_path=
# $HP_path=

If ( [System.IO.File]::Exists($EMC_path) ) { # -or ( [System.IO.File]::Exists($HP_path) ) {
	$app_array = @("HP Data Protector", "EMC NetWorker")
	"Found:"
	If ( [System.IO.File]::Exists($EMC_path) ) -not ( [System.IO.File]::Exists($HP_path) ) {
		"EMC NetWorker Only"
		for ($i=1;$i -lt 2; $i++) {	
			$app = Get-WmiObject -Class Win32_Product | Where-Object { 
				$_.Name -match $app_array[0] 
			}
		}
#	} If ( [System.IO.File]::Exists($HP_path) ) -not ( [System.IO.File]::Exists($EMC_path) ) {
#		"HP Data Protector Only"
#		for ($i=1;$i -lt 2; $i++) {	
#			$app = Get-WmiObject -Class Win32_Product | Where-Object { 
#				$_.Name -match $app_array[1] 
#			}
#		}
	} Else {
		"Both HP Data Protector and EMC NetWorker"
		for ($i=1;$i -lt 2; $i++) {	
			$app = Get-WmiObject -Class Win32_Product | Where-Object { 
				$_.Name -match $app_array[i] 
			}
		}
	} 
	$app.Uninstall()
} Else {
# "Both HP Data Protector and EMC NetWorker not found"
"EMC NetWorker not found"
}
