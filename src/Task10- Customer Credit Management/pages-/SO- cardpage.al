pageextension 50126 "So Ext" extends "Sales Order"
{
    layout
    {
        addafter("Requested Delivery Date")
        {
            field("Credit Check Amount"; Rec."Credit Check Amount")
            {
                ApplicationArea = All;
            }
            field("Credit Check Status"; Rec."Credit Check Status")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast("Request Approval")
        {
            action("Approve Credit")
            {
                Caption = 'Approve Credit';
                ToolTip = 'Approve Credit when credit check is passed';
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()

                begin
                    Rec."Credit Check Status" := Rec."Credit Check Status"::Passed;
                    Rec.Modify()
                end;

            }


            action("Check Credit Limit")
            {

                Caption = 'Check Credit Limit';
                ToolTip = 'First Check the credit limit ';
                Image = Check;
                ApplicationArea = All;




                trigger OnAction()
                var
                    CreditMgmt: Codeunit "Customer Credit Management";
                begin
                    CreditMgmt.CheckCreditLimit(Rec);
                end;
            }

        }
    }

    var
        myInt: Integer;
}