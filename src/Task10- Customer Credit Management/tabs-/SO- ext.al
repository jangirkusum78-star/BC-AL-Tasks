tableextension 50124 "So ext" extends "Sales Header"
{
    fields
    {
        field(50125; "Credit Check Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50126; "Credit Check Status"; Enum "Credit Check Status")
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