tableextension 50176 "Customer ext" extends "Customer"
{
    fields
    {
        field(50120; "VIP Customer"; Boolean)
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