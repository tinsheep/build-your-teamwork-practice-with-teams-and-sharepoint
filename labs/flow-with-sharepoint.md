# SharePoint + Flow

Create SharePoint approval Flows with "Request Sign Off" and a template for Modern pages.

## Lab 1 - Create "Request Sign Off" approval flow (for document libraries or lists)

A recently added approval flow "Request sign-off" provides an easy way to send an item for approval to someone else. This feature enables an open approval process that allows you to easily record whether or not a document or list item was approved or not. There is no setup required. For additional detail see [Introducing "Request sign-off" - an approval flow that requires no set up](https://techcommunity.microsoft.com/t5/PowerApps-Flow/Introducing-quot-Request-sign-off-quot-an-approval-flow-that/td-p/178586)

1. Browse to a document library with documents. *Note: if you are using a Contoso Microsoft demo tenant, you could use the "X1050 Launch" team site and "Legal and Compliance" folder for this lab. This also works for lists as well*

2. Selecting a file (but not a folder), and then pull down the Flow menu in the modern library or list UI, and select **Request sign-off**. This flow will appear alongside any other custom flow that you or others may have added to the library.

3. On invocation, this will tell you that it will send an approval request on your behalf, and ask your consent. Once this is provided, you can pick one or more approvers, and write a message to them for your approval request. If you add more than one approver, any one of them can approve your request.

4. Check the email of the person you sent the approval to. This will be an actionable message on clients that support it (meaning you can approve it directly from within Outlook). The approver can also provide some comments along with their decision. There will also be a link included that lets the approver view the item in question. Approve the message with some comments and note the change in Sign Off status.

## Lab 2 - Create modern pages approval flow using "Submit SharePoint page for approval" template

Site owners can configure page approval to add to the standard publishing process for a site. After adding page approval flow, new and updated pages will be not be published directly. Instead, only the completion of the approval flow will make changes visible to all readers of the site. For more information see [Announcing SharePoint page approvals](https://techcommunity.microsoft.com/t5/SharePoint/Announcing-SharePoint-page-approvals/td-p/215466)

1. Setup

    * Go to your favorite Modern SharePoint Site (or create one) something like "IT". *Note: if you are using a Contoso Microsoft demo tenant, you could use the "X1050 Launch" team site*
    * Go to the Pages library from the left hand side navigation.
    * Go to **Library Settings** from the site *gear* in the upper right corner then **Version Settings** ... then set *Require content approval for submitted items* to **Yes**.

2. Create a new Site Page and save it as a draft (be creative ;))
3. Select your new document in the library list
4. From the Flow dropdown select "configure page approval flow"
5. Add flow name like "X1050 Page Approval" and configure an approver - click **create**
6. Go back and open your document
7. Notice submit for approval in upper right instead of publish - Go ahead and submit it.
8. Try out the approve/reject library view from the view dropdown
9. Check the email of the approver you configured
10. Notice the actionable message and link in the email but lets instead open the linked item and approve on the page as approver to notice the integrated experience.
11. Make an edit to the page - notice submit for approval and submit
12. This time approve via email actionable message
13. Now review the page approval flow that was created in Flow

## Lab 3- Hacker edition: Enhance lab 2 by adding a nag email for an approval delay.

Hints:  initialize variable / set variable / parallel branch / do-until
