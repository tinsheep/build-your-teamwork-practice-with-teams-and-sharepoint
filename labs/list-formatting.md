# Using List Formatting to customize SharePoint

## Use column formatting to customize SharePoint

You can use column formatting to customize how fields in SharePoint lists and libraries are displayed. To do this, you construct a JSON object that describes the elements that are displayed when a field is included in a list view, and the styles to be applied to those elements. The column formatting does not change the data in the list item or file; it only changes how it’s displayed to users who browse the list. Anyone who can create and manage views in a list can use column formatting to configure how view fields are displayed.
<https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/column-formatting>

### Get started with column formatting

To open the column formatting pane, open the drop-down menu under a column. Under Column Settings, choose Format this column. A field with no formatting specified uses the default rendering. To format a column, enter the column formatting JSON in the box.

To preview the formatting, select Preview. To commit your changes, select Save. When you save, anyone who views the list will see the customization that you applied.

The easiest way to use column formatting is to start from an example and edit it to apply to your specific field. The following sections contain examples that you can copy, paste, and edit for your scenarios. There are also several samples available in the SharePoint/sp-dev-column-formatting repository. <https://github.com/SharePoint/sp-dev-column-formatting>

We will start by creating a new list and then try two column formatting scripts:

- Create a new list on any of your test sites called "Task Tracking"
    Site Contents >> + New >> List
- Add the following columns:
    Effort (number), Assigned To (person), and Status (choice)
    For the Status column, add "In progress", "Done", "Blocked", "In review", "Has issues" as choices (without the quotes)
- Add some rows to your list so that it looks something like this...
- ![screenshot of sample list](./images/sp-columnformatting-none.png)

#### Format a number column as a data bar

These formats apply background-color and border-top styles to create a data bar visualization of @currentField, which is a number field. These styles are applied using the special column formatting class sp-field-dataBars. The bars are sized differently for different values based on the way the width attribute of the main div is set.

''' JSON

    {
      "$schema": "https://developer.microsoft.com/json-schemas/sp/column-formatting.schema.json",
      "elmType": "div",
      "children": [
        {
          "elmType": "span",
          "txtContent": "@currentField",
          "style": {
            "padding-left": "8px",
            "white-space": "nowrap"
          }
        }
      ],
      "attributes": {
        "class": "sp-field-dataBars"
      },
      "style": {
        "padding": "0",
        "width": "=if(@currentField >= 20, '100%', (@currentField * 5) + '%')"
      }
    }

'''

1. Format the Effort column with as a Simple Data Bar using the number-data-bar.json file from the GitHub project below:

    <https://github.com/SharePoint/sp-dev-list-formatting/tree/master/column-samples/number-data-bar>

#### Conditional formatting based on the value in a text or choice field

You can apply conditional formatting to text or choice fields that might contain a fixed set of values. The following example applies different classes depending on whether the value of the field is Done, In Review, Has Issues, or another value.

''' JSON

    {
      "$schema": "https://developer.microsoft.com/json-schemas/sp/column-formatting.schema.json",
      "elmType": "div",
      "attributes": {
        "class": "=if(@currentField == 'Done', 'sp-field-severity--good', if(@currentField == 'In progress', 'sp-field-severity--low', if(@currentField == 'In review', 'sp-field-severity--warning', if(@currentField == 'Has issues', 'sp-field-severity--severeWarning', 'sp-field-severity--blocked')))) + ' ms-fontColor-neutralSecondary'"
      },
      "children": [
        {
          "elmType": "span",
          "style": {
            "display": "inline-block",
            "padding": "0 4px"
          },
          "attributes": {
            "iconName": "=if(@currentField == 'Done', 'CheckMark', if(@currentField == 'In progress', 'Forward', if(@currentField == 'In review', 'Error', if(@currentField == 'Has issues', 'Warning', 'ErrorBadge'))))"
          }
        },
        {
          "elmType": "span",
          "txtContent": "@currentField"
        }
      ]
    }

'''

1. Format the Status column with as text conditional format using the text-conditional-format.json file from the GitHub project below:

    <https://github.com/SharePoint/sp-dev-list-formatting/tree/master/column-samples/text-conditional-format#conditional-formatting-based-on-the-value-in-a-text-or-choice-field>

## Use view formatting to customize SharePoint

You can use view formatting to customize how views in SharePoint lists and libraries are displayed. To do this, you construct a JSON object that describes the elements that are displayed when a row is loaded in a list view and any styles to be applied to those elements. View formatting does not change the data in list items; it only changes how they're displayed to users who browse the list. Anyone who can create and manage views in a list can use view formatting to configure how views are displayed.
<https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/view-formatting>

### Get started with view formatting

To open the view formatting pane, open the view dropdown and choose Format this view.

The easiest way to use view formatting is to start from an example and edit it to apply to your specific view. The following sections contain examples that you can copy, paste, and customize for your specific needs. There are also several samples available in the SharePoint/sp-dev-list-formatting repository. <https://github.com/SharePoint/sp-dev-column-formatting>

Create a second list and then try two view formatting scripts:

- Create a new list on any of your test sites called "Feedback"
    Site Contents >> + New >> List
- Add the following columns:
    Feedback (text), DueDate (Date), Assigned To (person)
- Add some rows to your list so that it looks something like this...
- ![screenshot of sample list](./images/listformatting-additionalrowclass.png)

#### Conditional formatting based on date

This example applies the class sp-field-severity--severeWarning to a list view row when the item's DueDate is before the current date.

''' JSON

    {
      "schema": "https://developer.microsoft.com/json-schemas/sp/view-formatting.schema.json",
       "additionalRowClass": "=if([$DueDate] <= @now, 'sp-field-severity--severeWarning', '')"
    }

'''

1. Format the list view with conditional formatting based on date using the date-conditional-format.json file in the GitHub project below:

    <https://github.com/SharePoint/sp-dev-list-formatting/tree/master/view-samples/date-conditional-format>

#### Multi-line view rendering

You can use view formatting to define a totally custom layout of field values inside a row using the same syntax used in Column Formatting.

This example uses the rowFormatter element, which totally overrides the rendering of a list view row. The rowFormatter in this example creates a bounding 'div' box for every list view row. Inside this bounding box, the $Title and $Feedback fields are displayed on separate lines. Under those fields, a button element is displayed that, when clicked, does the same thing as clicking the list row in an uncustomized view, which is opening the property form for the item. This button is displayed conditionally, when the value of the $Assigned_x0020_To field (assumed to be a person/group field) matches the current signed-in user:

''' JSON

    {
      "schema": "https://developer.microsoft.com/json-schemas/sp/view-formatting.schema.json",
      "hideSelection": true,
      "hideColumnHeader": true,
      "rowFormatter": {
        "elmType": "div",
        "attributes": {
          "class": "sp-row-card"
        },
        "children": [
          {
            "elmType": "div",
            "style": {
              "text-align": "left"
            },
            "children": [
              {
                "elmType": "div",
                "attributes": {
                  "class": "sp-row-title"
                },
                "txtContent": "[$Title]"
              },
              {
                "elmType": "div",
                "attributes": {
                  "class": "sp-row-listPadding"
                },
                "txtContent": "[$Feedback]"
              },
              {
                "elmType": "button",
                "customRowAction": {
                  "action": "defaultClick"
                },
                "txtContent": "Give feedback",
                "attributes": {
                  "class": "sp-row-button"
                },
                "style": {
                  "display": {
                    "operator": "?",
                    "operands": [
                      {
                        "operator": "==",
                        "operands": [
                          "@me",
                          "[$Assigned_x0020_To.email]"
                        ]
                      },
                      "",
                      "none"
                    ]
                  }
                }
              }
            ]
          }
        ]
      }
    }

'''

1. Format the list view with multi-line view rendering with the multiline-view.json file in the GitHub project below:

    <https://github.com/SharePoint/sp-dev-list-formatting/tree/master/view-samples/multi-line-view>