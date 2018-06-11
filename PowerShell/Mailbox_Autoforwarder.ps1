Import-Module MSOnline
$O365Cred = Get-Credential
$O365Session = New-PSSession –ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $O365Cred -Authentication Basic -AllowRedirection
Import-PSSession $O365Session
Connect-MsolService –Credential $O365Cred 

$reportName="Forwarding-Rules-Report.csv"

#Getting All Mailbox in the Environment
Write-host "Getting All Mailboxes.."
$AllMailboxes = Get-Mailbox -resultSize unlimited

#if you Just need to Target User Mailbox only untag the below like and tag the one above.
#$AllMailboxes = Get-Mailbox -RecipientTypeDetails userMailbox -ResultSize unlimited 

#Placeholder for Rule Collection
$AllRules = @()

#counter
$c=0

foreach ($mbx in $allMailboxes)
{
$c++
Write-host "$C : Getting Rules For User Mailbox:" $mbx.Alias
$mbxRules= Get-InboxRule -Mailbox $mbx.Alias
$AllRules+=$MbxRules
}

$Rules = $AllRules | ? {$_.Description -match "@" -and $_.ForwardTo -ne $null -or $_.RedirectTo -ne $null}

$RulesDATA=@()

foreach ($rule in $Rules)
{

if ($rule.ForwardTo)
{
if (($rule.ForwardTo).Count   -gt 1)
{
foreach ($entry in $rule.ForwardTo)
{
if ($entry -match "@")
{
 $RulesD= New-Object -TypeName PSObject
 $RulesD| Add-Member -MemberType NoteProperty -Name Mailbox -Value $rule.MailboxOwnerID
 $RulesD| Add-Member -MemberType NoteProperty -Name ForwardTo -Value $($entry | % {$($_.split("[")[0]).Replace('"',"")})
 $RulesD| Add-Member -MemberType NoteProperty -Name RedirectTo -Value "n/a"
 $RulesDATA+=$rulesD
 }
}
}
Else{
if ($rule.ForwardTo -match "@")
{
 $RulesD= New-Object -TypeName PSObject
 $RulesD| Add-Member -MemberType NoteProperty -Name Mailbox -Value $rule.MailboxOwnerID
 $RulesD| Add-Member -MemberType NoteProperty -Name ForwardTo -Value $($rule.ForwardTo  | % {$($_.split("[")[0]).Replace('"',"")})
 $RulesD| Add-Member -MemberType NoteProperty -Name RedirectTo -Value "n/a"
 $RulesDATA+=$rulesD
}
   }
}
if ($rule.RedirectTo)
{
if (($rule.RedirectTo).Count   -gt 1)
{
foreach ($entry in $rule.RedirectTo)
{
 if ($entry -match "@") 
{
 $RulesD= New-Object -TypeName PSObject
 $RulesD| Add-Member -MemberType NoteProperty -Name Mailbox -Value $rule.MailboxOwnerID
 $RulesD| Add-Member -MemberType NoteProperty -Name ForwardTo -Value n/a
 $RulesD| Add-Member -MemberType NoteProperty -Name RedirectTo -Value $($entry  | % {$($_.split("[")[0]).Replace('"',"")})
 $RulesDATA+=$rulesD
}
}
}
Else{
if ($rule.RedirectTo -match "@") 
{
 $RulesD= New-Object -TypeName PSObject
 $RulesD| Add-Member -MemberType NoteProperty -Name Mailbox -Value $rule.MailboxOwnerID
 $RulesD| Add-Member -MemberType NoteProperty -Name ForwardTo -Value "N/A"
 $RulesD| Add-Member -MemberType NoteProperty -Name RedirectTo -Value $($rule.RedirectTo  | % {$($_.split("[")[0]).Replace('"',"")})
 $RulesDATA+=$rulesD 
 }
}
}
}

#exporting report Data to Csv File
$RulesDATA | Export-Csv $reportName -notype
