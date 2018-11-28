
Import-Module Microsoft.Online.SharePoint.Powershell
$usercredential = Get-Credential

Connect-SPOService -Url "https://mipancir-admin.sharepoint.com" -Credential $usercredential

Connect-PnPOnline -Url "https://mipancir.sharepoint.com" -Credentials $usercredential

#create the new site
$hubsiteUrl = New-PnPSite -Type TeamSite -title "Contoso marketing division" -alias "marketing" -Description "Main site for collaboration for marketing teams at Contoso"

#register the new site as a hub site
Register-SPOHubSite -Site $hubsiteUrl 

#Use the Set-SPOHubSite cmdlet to set the logo and description. In place of mylogo.png, specify the name of the image that you uploaded:

Connect-PnPOnline -Url $hubsiteUrl -Credentials $usercredential
Add-PnPFile -Path "C:\dev\git\building-your-teamwork-practice-with-teams-and-sharepoint\images\contoso.png" -Folder "SiteAssets" 

Set-SPOHubSite -Identity $hubsiteUrl -Description "Main hub site for collaboration on marketing activities across Contoso" -LogoUrl ($hubsiteUrl + "/SiteAssets/contoso.png")

#Run the Grant-SPOHubSiteRights cmdlet to grant a user rights to the marketing hub site.
Grant-SPOHubSiteRights -Identity $hubsiteUrl -Principals "michaelp@tinsheep.com" -Rights Join

#create a new site to associate with the hub
$childsiteUrl = New-PnPSite -Type TeamSite -title "Online advertising team" -alias "online-advertising" -Description "For collaboration on online advertising resources"

#Associate this site with the hub site by using the Add-SPOHubSiteAssociation cmdlet:
Add-SPOHubSiteAssociation -Site $childsiteUrl -HubSite $hubsiteUrl

#get hub site information
Get-SPOHubSite -Identity $hubsiteUrl

#clean up
Remove-SPOHubSiteAssociation -Site $childsiteUrl
Revoke-SPOHubSiteRights -Identity $hubsiteUrl -Principals "michaelp@tinsheep.com"
Unregister-SPOHubSite -Identity $hubsiteUrl
