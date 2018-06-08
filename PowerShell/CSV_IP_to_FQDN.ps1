<#
.SYNOPSIS
  Converts CSV of IPs to CSV of FQDN using nslookup
.INPUTS
  # C:\Users\b.calderbank\Desktop\HP_IPs.csv
.OUTPUTS
  # C:\Users\b.calderbank\Desktop\HP_FQDN.csv
.NOTES
  Version:        1.0
  Author:         Brett Calderbank
  Creation Date:  30/05/2018
  Purpose/Change: Initial script creation
  
.EXAMPLE
  ./CSV_IP_to_FQDN.ps1 - run script
#>

$x_table = Import-CSV C:\Users\b.calderbank\Desktop\HP_IPs.csv
$x_array = ($x_table | out-string -stream) -notmatch '^$' | select -Skip 2

$n = 0

Foreach ( $i in $x_array ) {
((nslookup $x_array[$n] | Select-String "^name:") -split ":\s+")[1] | Out-File C:\Users\b.calderbank\Desktop\HP_FQDN.csv
$n++
}
