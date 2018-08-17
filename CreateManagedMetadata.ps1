Add-PSSnapin Microsoft.SharePoint.PowerShell

$appPool = Get-SPServiceApplicationPool "ServiceAppPool"

$srvApp = New-SPMetadataServiceApplication -Name "Managed Metadata Service Application" -DatabaseName "SP2016_ManagedMetadataDB" -ApplicationPool $appPool
$srvAppProxy = New-SPMetadataServiceApplicationProxy -Name "Managed Metadata Service Application" -ServiceApplication $srvApp