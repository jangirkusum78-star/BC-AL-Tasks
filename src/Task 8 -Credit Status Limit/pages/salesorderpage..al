pageextension 50186 "sales order" extends "Sales Order"
{
    layout
    {
        addafter("Credit-risk-score")
        {
            field("Credit block status"; Rec."Credit block status")
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