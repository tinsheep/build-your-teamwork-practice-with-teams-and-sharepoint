
# Teams Governance and Onboarding

## Prerequisites - Which Modules do you need?

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

## Azure Active Directory cmdlets for configuring group settings

Azure Active Directory cmdlets for configuring group settings
<https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-settings-cmdlets>
Enforce a naming policy for Office 365 groups in Azure Active Directory (preview)
<https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-naming-policy>

## Teams & Skype Policy PowerShell commands Overview

<https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-overview>


## PowerShell Script to prepare for pilot group rollout

see - teamsonboardingandgovernance.ps1

1. Connect to Services
1. Get the unified group template
1. Create a directory setting
1. Set the unified group setting
1. Review group settings
1. Set lifecycle policy for group lifetime for a year
1. Create a Teams messaging policy for your pilot users
1. Provision a team for your pilot users

### Did that work?

1. Log into Teams and Skype Admin center to review your messaging policy.
    - Manually assign new pilot users to appropriate messaging policy.
1. Open up an in-private browser and try and create a team as a non-administrative user to test unified group policy settings, e.g. check group prefix or try naming your group one of your blocked names, check you group classifications.
1. Try adding a message with a giffy (or sticker), assuming you included this user to your new messaging policy.