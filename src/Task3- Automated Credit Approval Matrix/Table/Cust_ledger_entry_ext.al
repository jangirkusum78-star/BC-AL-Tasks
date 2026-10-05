tableextension 50170 "custledgentry ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50117; "High Risk Transaction"; Boolean)
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