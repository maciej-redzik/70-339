#This script is used for clean all synchronized users/groups created in Test tennant of office 365.
#It requires O365 management shell to work

#Install AzureAD module if not installed:
Install-Module -Name AzureAD

#Connect to Azure AD:
Connect-AzureAD     #In VSCode login dialog likes to appear under VSCode window :)

$allUsers = get-azureaduser -All $true
$unlicensedUsers = $allUsers | Where-Object { $_.AssignedLicenses.Count -eq 0 }

Write-Host "All users: $($allUsers.Count)"
Write-Host "Unlicensed users: $($unlicensedUsers.Count)"

#Remove all unlicensed users:
$unlicensedUsers | ForEach-Object { Remove-AzureADUser -ObjectId $_.UserPrincipalName }

foreach ($user in $unlicensedUsers) {
    Write-Host $user.UserPrincipalName
    Remove-AzureADUser -ObjectId $user.UserPrincipalName
}

#Remove all test groups:
$allGroups = Get-AzureADGroup -All $true

Write-Host "All groups: $($allGroups.Count)"

foreach ($group in $allGroups) {
    Write-Host $group.DisplayName
    Remove-AzureADGroup -ObjectId $group.ObjectId
}