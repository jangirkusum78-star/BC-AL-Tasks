pageextension 50122 "my-cust-cardpage" extends "Customer Card"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            field("Credit Approval Required"; Rec."Credit Approval Required")
            {
                ApplicationArea = All;
            }
            field("Credit Approval Limit"; Rec."Credit Approval Limit")
            {
                ApplicationArea = All;
            }
            field("Risk Rating"; Rec."Risk Rating")
            {
                ApplicationArea = All;
            }
        }
    }


    actions
    {
        addafter("Request Approval")
        {
            action("Set Risk Rating")
            {
                Caption = 'Set Risk Rating';
                Image = Check;
                ApplicationArea = All;


                trigger OnAction()
                var
                    riskmgmt: Codeunit "Check Risk rating";
                begin
                    riskmgmt.checkriskrating(rec);
                    CurrPage.Update(false);
                end;

            }
        }
    }

    var
        myInt: Integer;
}