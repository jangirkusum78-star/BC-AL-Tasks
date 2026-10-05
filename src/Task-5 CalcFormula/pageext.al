pageextension 50174 "sales order ext" extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("Outstanding line count"; Rec."Outstanding line count")
            {
                ApplicationArea = All;

            }
        }

        // actions
        // {
        //     // Add changes to page actions here
        // }

        // var
        //     myInt: Integer;
    }
}