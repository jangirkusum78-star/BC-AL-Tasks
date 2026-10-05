tableextension 50161 "Mypurchaseorderext" extends "Purchase Header"
{
    fields
    {
        field(50111; "COA(status)"; Enum "COA(Status)")
        {
            Caption = 'COA(status)';
            DataClassification = CustomerContent;
        }

    }

    // keys
    // {
    //     // Add changes to keys here
    // }

    // fieldgroups
    // {
    //     // Add changes to field groups here
    // }

    // var
    //     myInt: Integer;
}