Add-PSSnapin Microsoft.SharePoint.PowerShell

#register new managed user 'sp2016_service' for service applications
$strPass = Read-Host -AsSecureString ''
$serviceAccountCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "DEV\SP2016_Service", $strPass
$serviceAppUser = New-SPManagedAccount -Credential $serviceAccountCredentials

$appPool = Get-SPServiceApplicationPool | Where-Object {$_.Name -eq "ServiceAppPool"}

$secStoreApp = New-SPSecureStoreServiceApplication -Name "Secure Store Service Application" -ApplicationPool $appPool -AuditingEnabled:$true `
-DatabaseName "SP2016_SecureStoreDB" -AuditlogMaxSize 30
$secStoreAppProxy = New-SPSecureStoreServiceApplicationProxy -ServiceApplication $secStoreApp -Name "Secure Store Service Application Proxy" 

#If you have in central Administraion message like this:
#"Cannot complete this action as the Secure Store Shared Service is not responding. Please contact your administrator."
#Please check if "Secure Store Service" is started in SPServiceInstances (in Central Adm. -> System Settings -> Services on Server)

$secStoreApp = Get-SPServiceApplication | Where-Object { $_.DisplayName -eq "Secure Store Service Application" }
$secStoreApp.Provision()
iisreset.exe
