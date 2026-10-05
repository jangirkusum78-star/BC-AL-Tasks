report 50179 "Sales Order Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Sales_order;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            // DataItemTableView = sorting("No.") where("No." = filter('<>""'));
            DataItemTableView = where("No." = filter('<>""'));

            // Standard dataitem filtering can still be applied by the user naturally
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(No; "No.") { }
            column(Name; "Sell-to Customer Name") { }
            column(Address; "Ship-to Address") { }
            column(Order_Date; "Order Date") { }
            column(Posting_Date; "Posting Date") { }



            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item | "G/L Account"));

                column(Item_No; "No.") { }
                column(Description; Description) { }
                column(Variant_Code; "Variant Code") { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(Line_Amount; "Line Amount") { }
                trigger OnAfterGetRecord()
                begin
                    // If the item number or document number is blank, skip the record completely
                    if (SalesLine."No." = '') or (SalesLine."Document No." = '') then
                        CurrReport.Skip();
                end;

            }
        }
    }

    requestpage
    {
        SaveValues = true;
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(Document_No; Document_No)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                        // Added table relation so users can look up actual sales order numbers
                        TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
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

    rendering
    {
        layout(Sales_order)
        {
            Type = RDLC;
            LayoutFile = 'sales-order-reportlayout.rdl';
        }
    }
    //  trigger OnPreDataItem()
    //          begin
    //         //     // FIX 3: Apply the request page variable filter to the Sales Header dataitem
    //             if Document_No <> '' then
    //           SalesHeader.SetRange("No.", Document_No);
    //          end;





    trigger OnInitReport()
    begin
        // FIX 2: Fetch the Company Information record into memory
        if CompanyInfo.Get() then
            // FIX 1: Explicitly calculate the BLOB picture field so it loads the logo data
            CompanyInfo.CalcFields(Picture);
    end;
    // trigger OnAfterGetRecord()
    // begin
    //                 // If the item number or document number is blank, skip the record completely
    //     if (SalesLine."No." = '') or (SalesLine."Document No." = '') then
    //     CurrReport.Skip();
    // end;




    var
        Document_No: Code[20]; // Changed from 60 to 20 to match standard "No." field length
        CompanyInfo: Record "Company Information";
}


// report 50179 "Sales Order Report"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultRenderingLayout = Sales_order;

//     dataset
//     {
//         dataitem(SalesHeader; "Sales Header")
//         {
//             column(CompanyLogo; CompanyInfo.Picture) { }
//             // column(No; "Sell-to Customer No.") { }
//             column(Name; "Sell-to Customer Name") { }
//             column(Address; "Ship-to Address") { }
//             column(Order_Date; "Order Date") { }
//             column(Posting_Date; "Posting Date") { }

//             dataitem(SalesLine; "Sales Line")
//             {
//                 DataItemLink = "Document Type" = field("Document Type"),
//                            "Document No." = field("No.");
//                 column(Item_No; "No.") { }
//                 column(Description; Description) { }
//                 column(Variant_Code; "Variant Code") { }
//                 column(Unit_of_Measure_Code; "Unit of Measure Code") { }
//                 column(Quantity; Quantity) { }
//                 column(Unit_Price; "Unit Price") { }
//                 column(Line_Discount__; "Line Discount %") { }
//                 column(Line_Discount_Amount; "Line Discount Amount") { }


//             }
//         }
//     }

//     requestpage

//     {
//         SaveValues = true;
//         AboutTitle = 'Teaching tip title';
//         AboutText = 'Teaching tip content';
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     field(Document_No; Document_No)
//                     {
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(LayoutName)
//                 {

//                 }
//             }
//         }
//     }

//     rendering
//     {
//         layout(Sales_order)
//         {
//             Type = RDLC;
//             LayoutFile = 'sales-order-reportlayout.rdlc';
//         }
//     }

//     var
//         Document_No: Code[60];
//         CompanyInfo: Record "Company Information";
// }