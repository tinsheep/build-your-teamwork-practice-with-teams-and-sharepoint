Connect-PnPOnline -Url "https://mipancir.sharepoint.com" -Credentials $usercredential -Scopes "Group.ReadWrite.All","User.Read.All","Directory.Read.All","Sites.Read.All"

#get your unified group id
Get-PnPUnifiedGroup


Remove-PnPTenantSite -Url "https://mipancir.sharepoint.com/sites/online-advertising2" -SkipRecycleBin 
Remove-PnPUnifiedGroup -Identity a02bf908-93ca-4acb-9d22-3a7430089a81 // you can get group Ids from Get-PnPUnifiedGroup

Remove-SPOSite
Remove-SPODeletedSite