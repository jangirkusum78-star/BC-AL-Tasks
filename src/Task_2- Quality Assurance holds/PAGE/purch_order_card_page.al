pageextension 50162 "purchase order page" extends "Purchase Order"
{
    layout
    {
        addafter(General)
        {
            field("COA(status)"; Rec."COA(status)")
            {
                ApplicationArea = All;
                Style = Favorable;
                StyleExpr = (Rec."COA(status)" = Rec."COA(status)"::Received);
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