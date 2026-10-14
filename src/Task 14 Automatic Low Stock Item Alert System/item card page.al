//Task 2 — Display the field on the Item Card
//Let users enter and maintain the minimum stock quantity directly on the item card.



pageextension 50112 "Item card ext" extends "Item Card"
{
    layout
    {
        addafter("Over-Receipt Code")
        {
            field(Minimum_Stock_Quantity; Rec.Minimum_Stock_Quantity)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}