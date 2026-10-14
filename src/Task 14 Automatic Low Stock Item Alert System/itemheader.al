/* Whenever our inventory falls below the minimum stock level, I want Business Central to identify the 
item and notify our purchasing team so they can arrange replenishment."*/

//Task 1 — Extend the Item table
//Add a new field called Minimum Stock Quantity so the client can define the minimum acceptable inventory for each item.

tableextension 50111 "Item Ext" extends Item
{
    fields
    {
        field(50101; "Minimum_Stock_Quantity"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Stock Quantity';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}