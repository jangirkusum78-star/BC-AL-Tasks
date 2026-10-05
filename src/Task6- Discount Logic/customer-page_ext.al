pageextension 50178 "Customer page ext" extends "Customer Card"
{
    layout

    {
        addafter(Blocked)
        {
            field("VIP Customer"; Rec."VIP Customer")
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