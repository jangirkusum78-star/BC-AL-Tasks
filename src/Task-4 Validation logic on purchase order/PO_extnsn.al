tableextension 50165 "POextnsn" extends "Purchase Header"
{
    fields
    {
        field(50113; "PO-expiry-date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'PO-expirydate';
            trigger OnValidate()

            begin
                //"PO-expiry-date" := CalcDate('90d', "Order Date");
            end;
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