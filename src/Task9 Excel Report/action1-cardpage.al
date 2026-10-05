pageextension 50141 "My report action1" extends "Purchase Order"
{
    layout
    {

    }

    actions
    {
        addafter("Request Approval")
        {
            action(ExportPOToExcel)
            {
                ApplicationArea = All;
                Caption = 'ExportPOToExcel';
                ToolTip = 'Export Purchase order to excel';
                Image = Export;
                trigger OnAction()
                begin
                    Report.RunModal(Report::"MY Excel Report Practice", true, false, Rec);
                end;

            }
        }
    }

    var
        myInt: Integer;
}