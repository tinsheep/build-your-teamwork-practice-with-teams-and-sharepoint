# Create SharePoint hub sites using PowerShell

In this example, you'll learn how to create a SharePoint hub site and to associate another site with it. In this scenario, you are setting up sites for the Contoso marketing department:

- You will create a hub site that all other marketing sites will be associated with.
- You will then specify settings and permissions for the hub site.
- Finally, you will create a second site and associate it with the hub site.

## Connect to SPO

First, you need to connect to SharePoint Online by using Windows PowerShell. The commands use both the SharePoint Online Management Shell (-SPO) <https://www.microsoft.com/en-us/download/details.aspx?id=35588> and the SharePoint PnP PowerShell Online module (-PnP) <https://www.powershellgallery.com/packages/SharePointPnPPowerShellOnline> .

1. Start Windows PowerShell.

2. Run the Connect-SPOService cmdlet to connect to SharePoint Online. Sign in with your global or SharePoint admin credentials:

'''PowerShell

     Connect-SPOService -Url "https://<your tenant name>-admin.sharepoint.com"

'''

## Create a new hub site

Next, create the marketing site that will serve as a hub site that other sites can associate with. The intent is that any sites that are marketing-oriented will be part of the hub site. This applies common navigation and branding across the associated sites, enables team members to search across all the sites associated with the single hub site, and takes advantage of other hub site features.

1. Create the site using the New-PnPSite cmdlet:

'''PowerShell

    Connect-PnPOnline -SPOManagementShell
    #create the new site
    $hubsiteUrl = New-PnPSite -Type TeamSite
     -title "Contoso marketing division"
     -alias "marketing"
     -Description "Main site for collaboration for marketing teams at Contoso"

'''

1. Register the new marketing site as a hub site by using the Register-SPOHubSite cmdlet:

'''PowerShell

    #register the new site as a hub site
    Register-SPOHubSite -Site $hubsiteUrl

'''

## Set properties and permissions on the hub site

The hub site doesn't have a logo or description yet. We also want to constrain it so that only one person can make changes to the hub site.

### Set properties

1. Upload a logo image for the site by going to https://contoso.sharepoint.com/sites/marketing/SiteAssets and uploading any image you like. Make a note of the image file name.

2. Use the Set-SPOHubSite cmdlet to set the logo and description. In place of mylogo.jpg, specify the name of the image that you uploaded:

'''PowerShell

    Set-SPOHubSite
      -Identity $hubsiteUrl
      -LogoUrl https://contoso.sharepoint.com/marketing/SiteAssets/mylogo.jpg
      -Description "Main hub site for collaboration on marketing activities across Contoso"

'''

### Set Permissions

Now we will restrict access so that only a specific user can make changes to the hub site associations. You can use any valid user on your tenant (you can specify multiple users by separating them with a comma):

'''PowerShell

    Grant-SPOHubSiteRights -Identity $hubsiteUrl -Principals "michaelp@tinsheep.com,meganb@tinsheep.com" -Rights Join

'''

## Create and associate a new site

The final step is to create the site we want to associate with the hub. You can repeat these steps for as many sites as you want to join to the hub.

1. Provision the site by using the New-PnPSite cmdlet:

'''PowerShell

    #create a new site to associate with the hub
    $childsiteUrl New-PnPSite -Type TeamSite
      -title "Online advertising team"
      -alias "online-advertising"
      -Description "For collaboration on online advertising resources"

'''

1. Associate this site with the hub site by using the Add-SPOHubSiteAssociation cmdlet:

'''PowerShell

     #Associate this site with the hub site by using the Add-SPOHubSiteAssociation cmdlet:
     Add-SPOHubSiteAssociation
      -Site $childsiteUrl
      -HubSite $hubsiteUrl

'''

## Confirm the hub site is working

To confirm, you can either:

- Run the Get-SPOHubSite cmdlet.

- Sign in to SharePoint Online and view the hub site directly at <https://contoso.sharepoint.com/sites/marketing.>

The hub site navigation appears at the top of the site. If you go to the <https://contoso.sharepoint.com/sites/online-advertising> site, it shows the same hub site navigation at the top.
