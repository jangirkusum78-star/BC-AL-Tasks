report 50115 "My Excel Report "
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Vendor Posting Group";

            column(No_; "No.") { }
            column(Name; Name) { }
            column(Vendor_Posting_Group; "Vendor Posting Group") { }
            column(Currency_Code; "Currency Code") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Balance_LCY_; "Balance (LCY)") { }
            column(Balance_Due_LCY_; "Balance Due (LCY)") { }
            column(Purchaser_Code; "Purchaser Code") { }
            column(Country_Region_Code; "Country/Region Code") { }
            column(Blocked; Blocked) { }
            column(Address; Address) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Buy-from Vendor No." = field("No.");
                // Only show lines from actual Purchase Orders
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                    where("Document Type" = const(Order));
                column(DocumentNo; "Document No.") { }
                column(LineNo; "Line No.") { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(DirectUnitCost; "Direct Unit Cost") { }
                column(LineAmount; "Line Amount") { }


            }
            trigger OnAfterGetRecord()
            begin
                Populatepurchaseline();
            end;

        }
    }
    var
        ExcelBuffer: Record "Excel Buffer" temporary;

    // trigger 1
    trigger OnPreReport()
    begin
        CreateExcelHeader();
    end;

    trigger OnPostReport()
    begin
        CreateExcelFile();
    end;

    local procedure CreateExcelHeader()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('No', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor_Posting_Group', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Currency_Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment_terms_Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance_LCY_', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Balance_Due_LCY_', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Purchaser_Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Country_Region_Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Blocked', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Address', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Line No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Item No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Direct Unit Cost', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);


    end;
    // creating another procedure 
    local procedure Populatepurchaseline()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Vendor."No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor."Vendor Posting Group", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor."Currency Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor."Payment Terms Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor."Balance (LCY)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Vendor."Balance Due (LCY)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Vendor."Purchaser Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor."Country/Region Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Format(Vendor.Blocked), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Vendor.Address, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        // Purchase Line Data
        ExcelBuffer.AddColumn("Purchase Line"."Document No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Purchase Line"."Line No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Purchase Line"."No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Purchase Line".Description, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Purchase Line".Quantity, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Purchase Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Purchase Line"."Line Amount", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;


    // procedure 3 using on trigger onpostdataitem
    local procedure CreateExcelFile()
    begin
        ExcelBuffer.CreateNewBook('Vendor');
        ExcelBuffer.WriteSheet('Vendor', CompanyNAme, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Vendor Details');
        ExcelBuffer.OpenExcel();

    end;
}








