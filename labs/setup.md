# Setup your environment for PowerShell

## Connect to Office 365 Services

If this is the first time you are running PowerShell on your machine to connect to Office 365 Services, you may need to install the [Microsoft Online Services Sign-In Assistant](https://www.microsoft.com/en-us/download/details.aspx?id=41950).

Additionally, make sure you have the MSOnline module installed. Open an elevated Windows PowerShell command prompt (run Windows PowerShell as an administrator). Install the MSOnline module with the following command:

'''PowerShell

    Install-Module MSOnline

'''

## Add SharePoint module

[Getting started with SharePoint Online Management Shell](https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps)

'''PowerShell

    Install-Module -Name Microsoft.Online.SharePoint.PowerShell

'''

## Add additional modules:

- Azure AD Preview module
- Microsoft Teams Powershell module
- Skype for Business Online PowerShell module

Install Azure AD Preview Module - currently, the preview module is required for the Directory Setting Templates. For more information see - <https://docs.microsoft.com/en-us/powershell/azure/active-directory/install-adv2?view=azureadps-2.0>

'''PowerShell

    Install-module AzureADPreview

'''

The PowerShell controls for managing Microsoft Teams are in two different PowerShell modules: the Microsoft Teams PowerShell module https://www.powershellgallery.com/packages/MicrosoftTeams/0.9.5 (public preview) and the Skype for Business PowerShell module https://www.microsoft.com/en-us/download/details.aspx?id=39366. The Teams PowerShell module contains all of the cmdlets you need to create and manage the teams themselves, while the Skype for Business PowerShell module contains the controls for managing policies, configurations, and other Teams tools. The reference documents for PowerShell controls will tell you which module contains the cmdlet you're investigating. (Eventually, the two modules will be combined.)

'''PowerShell

    Install-Module -Name MicrosoftTeams

'''

Install Skype for Business Online, Windows PowerShell Module https://www.microsoft.com/en-us/download/details.aspx?id=39366 