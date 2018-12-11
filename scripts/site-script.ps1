Import-Module Microsoft.Online.SharePoint.Powershell
$usercredential = Get-Credential

#Connect to the admin site Url for your tenant - replace mipancir with your tenant name
Connect-SPOService -Url "https://mipancir-admin.sharepoint.com" -Credential $usercredential

Connect-PnPOnline -Url "https://mipancir.sharepoint.com" -Credentials $usercredential

$site_script = @'
 {
     "$schema": "schema.json",
         "actions": [
             {
                 "verb": "createSPList",
                 "listName": "Customer Tracking",
                 "templateType": 100,
                 "subactions": [
                     {
                         "verb": "SetDescription",
                         "description": "List of Customers and Orders"
                     },
                     {
                         "verb": "addSPField",
                         "fieldType": "Text",
                         "displayName": "Customer Name",
                         "isRequired": false,
                         "addToDefaultView": true
                     },
                     {
                         "verb": "addSPField",
                         "fieldType": "Number",
                         "displayName": "Requisition Total",
                         "addToDefaultView": true,
                         "isRequired": true
                     },
                     {
                         "verb": "addSPField",
                         "fieldType": "User",
                         "displayName": "Contact",
                         "addToDefaultView": true,
                         "isRequired": true
                     },
                     {
                         "verb": "addSPField",
                         "fieldType": "Note",
                         "displayName": "Meeting Notes",
                         "isRequired": false
                     }
                 ]
             }
         ],
             "bindata": { },
     "version": 1
            }
'@

 #Add a new site script by using the Add-SPOSiteScript cmdlet
 $site_script_id = Add-SPOSiteScript -Title "Create customer tracking list" -Content $site_script -Description "Creates list for tracking customer contact information"

 Get-SPOSiteScript -Identity $site_script_id

 #Create the site design
 $site_design_id = Add-SPOSiteDesign -Title "Contoso customer tracking" -WebTemplate "64" -SiteScripts $site_script_id -Description "Tracks key customer data in a list"

 Get-SPOSiteDesign -Identity $site_design_id


#use the new site design manually or with PowerShell:

#create a new site to apply the new site design to 
$teamsiteUrl = New-PnPSite -Type TeamSite -Title "Online advertising team" -alias "online-advertising" -Description "For collaboration on online advertising resources"

#apply site design to existing site
Invoke-SPOSiteDesign -Identity $site_design_id -WebUrl $teamsiteUrl


#clean up
Remove-SPOSiteDesign -Identity $site_design_id
Remove-SPOSiteScript -Identity $site_script_id
 