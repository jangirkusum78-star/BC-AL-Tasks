tableextension 50187 "sales header ext" extends "Sales Header"
{
    fields
    {
        field(50120; "Credit block status"; Enum "Credit block status")
        {
            DataClassification = CustomerContent;
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