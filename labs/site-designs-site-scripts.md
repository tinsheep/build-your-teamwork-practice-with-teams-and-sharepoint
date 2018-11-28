# Create Site Script

## Create the site script in JSON

A site design is a collection of actions that SharePoint runs when creating a new site. Actions describe changes to apply to the new site, such as creating a new list or applying a theme. The actions are specified in a JSON script, which is a list of all actions to apply. When a script runs, SharePoint completes each action in the order listed.

Each action is specified by the "verb" value in the JSON script. Also, actions can have subactions that are also "verb" values. In the following JSON, the script specifies to create a new list named Customer Tracking, and then subactions set the description and add several fields to define the list.

Download and install the [SharePoint Online Management Shell] (<https://www.microsoft.com/en-us/download/details.aspx?id=35588).> If you already have a previous version of the shell installed, uninstall it first and then install the latest version.

Follow the instructions at Connect to [SharePoint Online PowerShell] <https://technet.microsoft.com/en-us/library/fp161372.aspx> to connect to your SharePoint tenant.

Create - and assign the JSON that describes the new script - to a variable as shown in the following PowerShell code. You can view and reference the latest JSON schema file here:
(<https://developer.microsoft.com/json-schemas/sp/site-design-script-actions.schema.json)>

'''powershell

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

'''

## Add the site script

'''powershell

    $site_script_id = Add-SPOSiteScript
     -Title "Create customer tracking list"
     -Content $site_script
     -Description "Creates list for tracking customer contact information"

'''

## Create the site design

'''powershell

    $site_design_id = Add-SPOSiteDesign
     -Title "Contoso customer tracking"
     -WebTemplate "64"
     -SiteScripts $site_script_id
     -Description "Tracks key customer data in a list"

'''

## Use the new site design

Now that you've added a site script and site design, you can use it to create new sites through the self-service site creation experience or apply the site design to an existing site using the Invoke-SPOSiteDesign command in PowerShell. If you are using hub sites you can even associate a site design to a hub so it gets applied to all joining sites.

### Manual new site creation

1. Go to the home page of the SharePoint site that you are using for development.
2. Choose Create site.
3. Choose Team site.
4. In the Choose a design drop-down, select your site design customer orders.
5. In Site name, enter a name for the new site Customer order tracking.
6. Choose Next.
7. Choose Finish.
8. A pane indicates that your script is being applied. When it is done, choose View updated site.
9. You will see the custom list on the page.

### Powershell new site creation

'''PowerShell

    #create a new site to apply the new site design to 
    $teamsiteUrl = New-PnPSite -Type TeamSite -Title "Online advertising team" -alias "online-advertising" -Description "For collaboration on online advertising resources"

    #apply site design to existing site
    Invoke-SPOSiteDesign -Identity $site_design_id -WebUrl $teamsiteUrl

'''