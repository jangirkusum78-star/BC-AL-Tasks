report 50118 "My Purchase Order Draft"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = purchase_order;

    dataset
    {
        dataitem(purchaseheader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Order));


            column(AmountInWordsText; AmountInWords) { }
            column(TotalLineAmount; TotalLineAmount) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(GSt_vendor_type; "GST Vendor Type") { }
            column(vendor_gst_reg; "Vendor GST Reg. No.") { }
            column(PO_No; "Buy-from Vendor No.") { }
            column(Vendor_Name; "Buy-from Vendor Name") { }
            column(Address; "Buy-from Address") { }
            column(State_code; "Pay-to Address") { }
            column(contact; "Buy-from Contact") { }
            column(PO_Date; "Order Date") { }
            column(PO_ExpiryDate; "PO-expiry-date") { }
            column(Currency_Code; "Currency Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Nature_of_Supply; "Nature of Supply") { }



            dataitem(Purchaseline; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                                "Document No." = field("No.");
                DataItemTableView = sorting(
                    "Document Type",
                    "Document No.",
                    "Line No."
                );


                // column(GST_group_type;gst)

                column(Item_no; "No.") { }
                column(Description; Description) { }
                column(HSN; "HSN/SAC Code") { }
                column(Quantity; Quantity) { }
                column(UOM; "Unit of Measure Code") { }
                column(Rate; "Unit Cost (LCY)") { }
                column(GST; "GST Group Code") { }
                column(Lineamount; "Line Amount") { }
                column(Discount_Amount; "Line Discount Amount") { }
                //column(TotalLineAmount; TotalLineAmount) { }
                //column(AmountInWords; AmountInWords) { }

                trigger OnAfterGetRecord()
                begin
                    TotalLineAmount += "Line Amount";
                end;

            }
            trigger OnAfterGetRecord()
            var
                PurchaseLineRec: Record "Purchase Line";
            begin
                TotalLineAmount := 0;

                PurchaseLineRec.SetRange(
                    "Document Type",
                    "Document Type"
                );

                PurchaseLineRec.SetRange(
                    "Document No.",
                    "No."
                );

                if PurchaseLineRec.FindSet() then
                    repeat
                        TotalLineAmount += PurchaseLineRec."Line Amount";
                    until PurchaseLineRec.Next() = 0;
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
                group(Option)
                {
                    field(Document_no; Document_no)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                        // Added table relation so users can look up actual sales order numbers
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                    }
                }
            }
        }

    }

    rendering
    {
        layout(purchase_order)
        {
            Type = RDLC;
            LayoutFile = 'purchase_order_report.rdl';
        }
    }

    trigger OnInitReport()
    begin
        // FIX 2: Fetch the Company Information record into memory
        if CompanyInfo.Get() then
            // FIX 1: Explicitly calculate the BLOB picture field so it loads the logo data
            CompanyInfo.CalcFields(Picture);
    end;


    var
        Document_no: Code[30];
        CompanyInfo: Record "Company Information";

        TotalLineAmount: Decimal;
        // NoText: array[2] of Text[80];
        AmountInWords: Text[250];





}