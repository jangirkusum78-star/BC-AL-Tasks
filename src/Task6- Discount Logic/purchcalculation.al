pageextension 50179 "purch-card-page" extends "Purchase Order Subform"
{
    layout
    {
        modify("Qty. to Invoice")
        {
            Editable = Isboolean;
        }
    }

    trigger OnAfterGetRecord()
    var
        Isboolean: Boolean;
        Rec: Record "Purchase Line";
    begin
        if Rec."Unit of Measure" = '' then begin
            Isboolean := false;
        end
        else
            Isboolean := true;

    end;

    var
        Isboolean: Boolean;

}
