<#
.SYNOPSIS
  Pull the following from the DC:
   # Local Time
   # Desktop settings
   # BIOS info
   # Installed hotfixes
   # Operating System Version Information
   # Local Users and owner
   # All services on local machine
   # Service accounts
   # Return local groups on the machine
   # Domain admins
   # Domain users
   # Global groups for domain
   # Details of computers on the domain
.INPUTS
  None
.OUTPUTS
  C:\evidence
  C:\evidence\evidence.zip
.NOTES
  Version:        1.0
  Author:         Brett
  Creation Date:  14/05/2018
  Purpose/Change: Initial script development
  
.EXAMPLE
  ./AD-details.ps1 - run script
#>

Import-Module ActiveDirectory

New-Item c:\evidence -ItemType directory # Create evidence directory

 # Local Time
Get-CimInstance -ClassName Win32_LocalTime -ComputerName . >C:\evidence\TIME.TXT

 # Local Checks
Get-CimInstance -ClassName Win32_Desktop -ComputerName . | Select-Object -ExcludeProperty "CIM*" >C:\evidence\DTPINFO.TXT ### Desktop settings
Get-CimInstance -ClassName Win32_BIOS -ComputerName . >C:\evidence\BIOS.TXT ### BIOS info
Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName . >C:\evidence\HOTFIXES.TXT ### Installed hotfixes
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion >C:\evidence\OSINFO.TXT ### Operating System Version Information
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property *user* >C:\evidence\LUSRS.TXT ### Local Users and owner
Get-Service >C:\evidence\SERVICES.TXT # All services on local machine

 # Service accounts
Get-ADServiceAccount -Filter * >C:\evidence\ACCOUNTS.TXT

 # Return local groups on the machine
Get-LocalGroup >C:\evidence\LGRP.TXT

 # Domain checks
Get-ADUser -filter * >C:\evidence\USERS.TXT ### Domain users
Get-ADGroupMember "Domain ADmins" | select name,distinguishedName >C:\evidence\DADMINS.TXT ### Domain admins

 # Return global groups for domain
Get-ADGroup -Filter * >C:\evidence\DGRP.TXT 
 
 # Get details of computers on the domain
Get-ADComputer -Filter {enabled -eq $true} -properties *|select Name, DNSHostName, OperatingSystem, LastLogonDate >C:\evidence\ADCOMPS.TXT

 # Compress into zip
Compress-Archive -LiteralPath C:\evidence -CompressionLevel Optimal -DestinationPath C:\evidence\evidence.zip

 # Email to bcalderbank@itlab.com
Send-MailMessage -To "Brett Calderbank <bcalderbank@itlab.com>" -From "Investigation - $Client <Investigations@itlab.com>" -Subject "$Client evidence" -Attachments "C:\evidence.zip" 
