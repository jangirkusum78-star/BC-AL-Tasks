pageextension 50127 "Soext" extends "Sales Order"
{
    layout
    {
        addafter("No. of Archived Versions")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
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