Get-msoluser -UserPrincipalName $User-Name | Select-Object UserPrincipalName -ExpandProperty StrongAuthenticationRequirements
