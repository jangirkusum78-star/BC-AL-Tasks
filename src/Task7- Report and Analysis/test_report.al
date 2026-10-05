report 50180 "Detail gst Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'test.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No; "Sell-to Customer No.") { }
            column(Name; "Sell-to Customer Name") { }
            column(Address; "Ship-to Address") { }
            column(Order_Date; "Order Date") { }
            column(Posting_Date; "Posting Date") { }

            trigger OnPreDataItem()
            begin
                // This applies the value entered in the request page to the Sales Header table
                if DocumentNoFilter <> '' then
                    SetFilter("No.", DocumentNoFilter);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    // Added the Document No. field here
                    field(DocumentNoField; DocumentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                        ToolTip = 'Specifies the Sales Header Document Number to filter the report.';
                        TableRelation = "Sales Header"."No."; // Adds a dropdown lookup to select existing numbers
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        DocumentNoFilter: Code[20]; // Variable to store the user input
}
