pageextension 50142 "action on report" extends "Purchase Order List"
{


    actions
    {
        addafter(Release)
        {
            action(ExportPurchaseOrdersToExcel)
            {
                ApplicationArea = All;
                Caption = 'ExportPurchaseOrdersToExcel';
                ToolTip = 'Export  all Purchase orders to excel';
                Image = Export;
                trigger OnAction()
                begin
                    Report.RunModal(Report::"MY Excel Report Practice", true, false, Rec);
                end;

            }
        }
    }
}


