#************************************************
# PurgeAllKerbTickets.ps1
# Version 1.0
# Date: 6-12-2014
# Author: Tim Springston [MSFT]
# Description: On a specific computer the script is ran on, 
#  this script finds all logon sessions which have Kerberos
#  tickets cached and for each session purges the ticket granting
#   tickets and the tickets using klist.exe.
#************************************************
cls

function GetKerbSessions
	{
	$Sessions = @()
	$WMILogonSessions = gwmi win32_LogonSession
	foreach ($WMILogonSession in $WMILogonSessions)
		{
		$LUID = [Convert]::ToString($WMILogonSession.LogonID, 16)
		$LUID = '0x' + $LUID
		$Sessions += $LUID
		}
	return $sessions
	}

Write-Host "WARNING: This script will purge all cached Kerberos tickets on the local computer for all sessions (whether interactive, network or other sessions)."  -backgroundcolor Red 
Write-Host "In a well-connected environment clients will request and obtain Kerberos tickets on demand without interruption. If not well-connected to a domain controller (remote network) then further network resource authentication may fail or use NTLM if tickets are purged." -BackgroundColor red
Write-Host "Confirm whether to purge by entering YES"
$Response = Read-Host

if ($Response -match 'YES')
	{
	$sessions = GetKerbSessions

	foreach ($Session in $sessions)
		{
		$PurgedTix = klist.exe -li $Session purge
		}
	Write-Host "All tickets purged!" -backgroundcolor green
	}
	else
		{
		Write-Host "Confirmation not received. NOT purging tickets." -backgroundcolor yellow
		}
