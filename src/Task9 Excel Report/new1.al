report 50106 "Excel GL Report"
{
    UsageCategory = ReportsAndAnalysis;
    //Caption = 'G/L Calculation Report';
    ApplicationArea = All;
    ProcessingOnly = true; // Prevents BC from demanding a layout layout file

    dataset
    {
        dataitem(GeneralEntry; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "G/L Account No.";

            column(Posting_Date; "Posting Date") { }
            column(G_L_Account_No_; "G/L Account No.") { }
            column(G_L_Account_Name; "G/L Account Name") { }
            column(Document_No_; "Document No.") { }
            column(Document_Type; "Document Type") { }
            column(Description; Description) { }
            column(Source_Code; "Source Code") { }
            column(Source_No_; "Source No.") { }
            column(Source_Type; "Source Type") { }
            column(Net_Amount; Amount) { }
            column(Source_Currency_Amount; "Source Currency Amount") { }
            column(VAT_Reporting_Date; "VAT Reporting Date") { }
            column(Entry_No_; "Entry No.") { }
            column(External_Document_No_; "External Document No.") { }
            column(Credit_Amount; "Credit Amount") { }
            column(Debit_Amount; "Debit Amount") { }
            column(ReportCaption; ReportCaption) { }
            column(CompanyName; CompanyInfo.Name) { }


            trigger OnPreDataItem()
            begin
                TotalCredit := 0;
                TotalDebit := 0;
                TotalNet := 0;
                PreText := GetFilter("Posting Date");

                ExcelBuffer.DeleteAll();
                RowNo := 0;

                // 1. Set Report Headers explicitly via AL Code using fixed Row/Col positions
                RowNo += 1; // Row 1
                ExcelBuffer.Init();
                ExcelBuffer.Validate("Row No.", RowNo);
                ExcelBuffer.Validate("Column No.", 1);
                ExcelBuffer."Cell Value as Text" := ReportCaption;
                ExcelBuffer.Bold := true;
                ExcelBuffer.Insert();

                RowNo += 1; // Row 2
                ExcelBuffer.Init();
                ExcelBuffer.Validate("Row No.", RowNo);
                ExcelBuffer.Validate("Column No.", 1);
                ExcelBuffer."Cell Value as Text" := CompanyInfo.Name;
                ExcelBuffer.Italic := true;
                ExcelBuffer.Insert();

                RowNo += 1; // Row 3
                ExcelBuffer.Init();
                ExcelBuffer.Validate("Row No.", RowNo);
                ExcelBuffer.Validate("Column No.", 1);
                ExcelBuffer."Cell Value as Text" := 'Filter: ' + PreText;
                ExcelBuffer.Insert();

                RowNo += 1; // Row 4 (Leave blank for visual spacing)

                // 2. Set Up Column Headers (Row 5) - Explicitly Bold
                RowNo += 1;
                CreateColumnHeader(1, 'Posting Date');
                CreateColumnHeader(2, 'G/L Account No.');
                CreateColumnHeader(3, 'G/L Account Name');
                CreateColumnHeader(4, 'Document No.');
                CreateColumnHeader(5, 'Document Type');
                CreateColumnHeader(6, 'Description');
                CreateColumnHeader(7, 'Debit Amount');
                CreateColumnHeader(8, 'Credit Amount');
                CreateColumnHeader(9, 'Net Amount');
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(DebitAmount);
                Clear(CreditAmount);

                if Amount > 0 then
                    DebitAmount := Amount
                else if Amount < 0 then
                    CreditAmount := Abs(Amount);

                TotalCredit += CreditAmount;
                TotalDebit += DebitAmount;
                TotalNet += Amount;

                // 3. Populate Data Rows using exact column mapping
                RowNo += 1;
                AddDataCell(1, Format("Posting Date"), ExcelBuffer."Cell Type"::Date, '');
                AddDataCell(2, "G/L Account No.", ExcelBuffer."Cell Type"::Text, '');
                AddDataCell(3, "G/L Account Name", ExcelBuffer."Cell Type"::Text, '');
                AddDataCell(4, "Document No.", ExcelBuffer."Cell Type"::Text, '');
                AddDataCell(5, Format("Document Type"), ExcelBuffer."Cell Type"::Text, '');
                AddDataCell(6, Description, ExcelBuffer."Cell Type"::Text, '');
                AddDataCell(7, Format(DebitAmount, 0, 9), ExcelBuffer."Cell Type"::Number, '#,##0.00');
                AddDataCell(9, Format(Amount, 0, 9), ExcelBuffer."Cell Type"::Number, '#,##0.00');
            end;

            trigger OnPostDataItem()
            begin
                // 4. Populate the Grand Total Row (Only targeted cells to prevent null values)
                RowNo += 1;

                // Add "Grand Total" label in the first column only
                AddTotalCell(1, TotalCaption, ExcelBuffer."Cell Type"::Text, '');

                // Jump straight to columns 7, 8, and 9. Skipping columns 2-6 completely fixes the null errors.
                AddTotalCell(7, Format(TotalDebit, 0, 9), ExcelBuffer."Cell Type"::Number, '#,##0.00');
                AddTotalCell(8, Format(TotalCredit, 0, 9), ExcelBuffer."Cell Type"::Number, '#,##0.00');
                AddTotalCell(9, Format(TotalNet, 0, 9), ExcelBuffer."Cell Type"::Number, '#,##0.00');

                // 5. Generate and download Excel
                ExcelBuffer.CreateNewBook('MIS Report');
                ExcelBuffer.WriteSheet(ReportCaption, CompanyName, UserId);
                ExcelBuffer.CloseBook();
                ExcelBuffer.OpenExcel();
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        TotalCaption := 'Grand Total';
        ReportCaption := 'GENERAL LEDGER CALCULATION REPORT';
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        CompanyInfo: Record "Company Information";
        RowNo: Integer;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        TotalNet: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        PreText: Text;
        TotalCaption: Text;
        ReportCaption: Text;

    local procedure CreateColumnHeader(ColNo: Integer; HeaderName: Text)
    begin
        ExcelBuffer.Init();
        ExcelBuffer.Validate("Row No.", RowNo);
        ExcelBuffer.Validate("Column No.", ColNo);
        ExcelBuffer."Cell Value as Text" := HeaderName;
        ExcelBuffer.Bold := true; // Bolds all column names
        ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Text;
        ExcelBuffer.Insert();
    end;

    local procedure AddDataCell(ColNo: Integer; CellValue: Text; CellType: Option; NumberFormat: Text)
    begin
        ExcelBuffer.Init();
        ExcelBuffer.Validate("Row No.", RowNo);
        ExcelBuffer.Validate("Column No.", ColNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer."Cell Type" := CellType;
        ExcelBuffer."NumberFormat" := NumberFormat;
        ExcelBuffer.Insert();
    end;

    local procedure AddTotalCell(ColNo: Integer; CellValue: Text; CellType: Option; NumberFormat: Text)
    begin
        ExcelBuffer.Init();
        ExcelBuffer.Validate("Row No.", RowNo);
        ExcelBuffer.Validate("Column No.", ColNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Bold := true; // Make grand totals bold
        ExcelBuffer."Cell Type" := CellType;
        ExcelBuffer."NumberFormat" := NumberFormat;
        ExcelBuffer.Insert();
    end;
}
