tableextension 50172 "Salesheaderext" extends "Sales Header"
{
    fields
    {
        field(50131; "Outstanding line count"; Integer)
        {
            //taClassification= ustomercontent;
            Caption = 'Outstanding line count';
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), Quantity = filter(>= 10)));
            Editable = false;

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