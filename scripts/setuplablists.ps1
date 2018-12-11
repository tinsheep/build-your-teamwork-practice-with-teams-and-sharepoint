
Import-Module Microsoft.Online.SharePoint.Powershell
$usercredential = Get-Credential

#Connect to the admin site Url for your tenant - replace mipancir with your tenant name
Connect-SPOService -Url "https://mipancir-admin.sharepoint.com" -Credential $usercredential

Connect-PnPOnline -Url "https://mipancir.sharepoint.com" -Credentials $usercredential

#name the site whatver you would like
$alias = "ITGroup1"
$title = "IT Group"

# Create a test site
$childsiteUrl = New-PnPSite -Type TeamSite -title $title -alias $alias -Description "For collaboration on online advertising resources"

# Connect to our new site
Connect-PnPOnline -Url $childsiteUrl -Credentials $usercredential

# Create a test list for "Flow with Teams" Lab 2
$listName="ChannelRequest"  
New-PnPList -Title $listName -Url "ChannelRequest" -Template GenericList -EnableVersioning -OnQuickLaunch

Add-PnPField -List $listName -DisplayName "Channel Name" -InternalName "ChannelName" -Type Text -AddToDefaultView  
Add-PnPField -List $listName -DisplayName "Purpose" -InternalName "Purpose" -Type Text -AddToDefaultView  
Add-PnPField -List $listName -DisplayName "Requestor" -InternalName "Requestor" -Type User -AddToDefaultView

# Create a test list for column and row formatting lab
$listName="TaskTracking"  
New-PnPList -Title $listName -Url $listName -Template GenericList -EnableVersioning -OnQuickLaunch

Add-PnPField -List $listName -DisplayName "Effort" -InternalName "Effort" -Type Number -AddToDefaultView  
Add-PnPField -List $listName -DisplayName "Assigned To" -InternalName "AssignedTo" -Type User -AddToDefaultView
$choices = "In progress","Done","Blocked","In review","Has issues"
Add-PnPField -List $listName -DisplayName "Status" -InternalName "Status" -Type  Choice  -Choices $choices   -AddToDefaultView
