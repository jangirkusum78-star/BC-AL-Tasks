tableextension 50101 "My Vendor" extends Vendor
{
    fields
    {
        field(50101; Quality_Rating; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 5;
            // DecimalPlaces = 0 : 0;

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