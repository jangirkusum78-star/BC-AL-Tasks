pageextension 50170 "cust-ledg page" extends "Customer Ledger Entries"
{
    layout
    {
        addlast(content)
        {
            field("High Risk Transaction"; Rec."High Risk Transaction")
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