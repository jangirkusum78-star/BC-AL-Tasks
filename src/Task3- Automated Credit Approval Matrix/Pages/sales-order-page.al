pageextension 50169 "Sales-order-ext" extends "Sales Order"
{
    layout
    {
        addafter("Status")
        {
            field("CreditStatus"; Rec."CreditStatus")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Credit-risk-score"; Rec."Credit-risk-score")
            {
                ApplicationArea = All;
                Editable = false;
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