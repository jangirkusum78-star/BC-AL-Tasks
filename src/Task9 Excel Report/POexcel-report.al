
report 50110 "MY Excel Report Practice"
{
    Caption = 'Purchase Order Excel';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Order));

            column(PONo; "No.") { }
            column(VendorNo; "Buy-from Vendor No.") { }
            column(VendorName; "Buy-from Vendor Name") { }
            column(OrderDate; "Order Date") { }
            column(ExpectedReceiptDate; "Expected Receipt Date") { }
            column(Status; Status) { }

            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink =
                    "Document Type" = field("Document Type"),
                    "Document No." = field("No.");

                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(LocationCode; "Location Code") { }
                column(Quantity; Quantity) { }
                column(UnitCost; "Direct Unit Cost") { }
                column(LineAmount; "Line Amount") { }
                column(QuantityReceived; "Quantity Received") { }
                column(QuantityInvoiced; "Quantity Invoiced") { }
                column(OutstandingQuantity; "Outstanding Quantity") { }

                trigger OnAfterGetRecord()
                begin
                    AddPurchaseLineToExcel();
                end;
            }
        }
    }

    var
        ExcelBuffer: Record "Excel Buffer" temporary;

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

        ExcelBuffer.AddColumn(
            'PO No.',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Vendor No.',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Vendor Name',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Status',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Order Date',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Date);

        ExcelBuffer.AddColumn(
            'Expected Receipt Date',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Date);

        ExcelBuffer.AddColumn(
            'Item No.',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Description',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Location Code',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            'Quantity',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            'Unit Cost',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            'Line Amount',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            'Quantity Received',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            'Quantity Invoiced',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            'Outstanding Quantity',
            false,
            '',
            true,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);
    end;

    local procedure AddPurchaseLineToExcel()
    begin
        ExcelBuffer.NewRow();

        // Purchase Header information
        ExcelBuffer.AddColumn(
            PurchaseHeader."No.",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseHeader."Buy-from Vendor No.",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseHeader."Buy-from Vendor Name",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            Format(PurchaseHeader.Status),
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseHeader."Order Date",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Date);

        ExcelBuffer.AddColumn(
            PurchaseHeader."Expected Receipt Date",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Date);

        // Purchase Line information
        ExcelBuffer.AddColumn(
            PurchaseLine."No.",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseLine.Description,
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseLine."Location Code",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(
            PurchaseLine.Quantity,
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            PurchaseLine."Direct Unit Cost",
            false,
            '',
            false,
            false,
            false,
            '#,##0.00',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            PurchaseLine."Line Amount",
            false,
            '',
            false,
            false,
            false,
            '#,##0.00',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            PurchaseLine."Quantity Received",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            PurchaseLine."Quantity Invoiced",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(
            PurchaseLine."Outstanding Quantity",
            false,
            '',
            false,
            false,
            false,
            '',
            ExcelBuffer."Cell Type"::Number);
    end;

    local procedure CreateExcelFile()
    begin
        ExcelBuffer.CreateNewBook('Purchase Orders');

        ExcelBuffer.WriteSheet(
            'Purchase Orders',
            CompanyName,
            UserId);

        ExcelBuffer.CloseBook();

        ExcelBuffer.SetFriendlyFilename('Purchase Order Report');

        ExcelBuffer.OpenExcel();
    end;
}
