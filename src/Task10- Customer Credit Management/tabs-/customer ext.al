tableextension 50121 "customer extens" extends "Customer"
{
    fields
    {
        field(50121; "Credit Approval Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50122; "Credit Approval Limit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50123; "Risk Rating"; Enum "Risk Rating")
        {
            DataClassification = CustomerContent;
            //heckriskrating();
        }

    }
    /* another task in same table as adding field enum risk rating  to set it  according to balance 
    */
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