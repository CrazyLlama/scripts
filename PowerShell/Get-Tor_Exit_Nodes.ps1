# Pull latest .txt from CheckPoint

$v = Invoke-WebRequest "https://secureupdates.checkpoint.com/IP-list/TOR.txt"

# Export .txt to specified location

$v.content | Out-File TORExitNodesExport.txt
