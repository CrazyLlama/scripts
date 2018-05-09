<#
.SYNOPSIS
sqlite.ps1 - Install, run, and uninstall sqlite for all you hacky needs.

.OUTPUTS
Should be no outputs other than what is generated in the sqlite session.

.EXAMPLE
.\sqlite.ps1 - _Runs the script_

.NOTE
Underscores denote sarcasm
#>


# Change to "Downloads" and create placeholder for download
Set-Location -Path "Downloads"
New-Item Downloads\sqlite-tools-win32-x86-3230100.zip -ItemType file

# Download sqlite and expand archive
(new-object System.Net.WebClient).DownloadFile("https://www.sqlite.org/2018/sqlite-tools-win32-x86-3230100.zip","Downloads\sqlite-tools-win32-x86-3230100.zip")
Expand-Archive -Path sqlite-tools-win32-x86-3230100.zip 

# Change dir to sqlite tools
Push-Location sqlite-tools-win32-x86-3230100\sqlite-tools-win32-x86-3230100

# Run the bitch
.\sqlite3.exe 
<# 
 >.shell cd C:\Users\[username]\AppData\Local\Google\Chrome\User^ Data\Default
 >.open History
 >
#>

# Go back to where you came from
Pop-Location

# Cleanup
Remove-Item sqlite-tools-win32-x86-3230100 -recurse
Remove-Item sqlite-tools-win32-x86-3230100.zip
