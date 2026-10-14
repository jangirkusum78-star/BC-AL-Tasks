report 50105 "MyExcel Mis Report"
{
    DefaultRenderingLayout = "GLReport";

    UsageCategory = ReportsAndAnalysis;
    Caption = 'G/L Calculation Report';
    ApplicationArea = All;




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
                clear(TotalCredit);
                clear(TotalCredit);
                clear(TotalNet);
                GLAccountCount := 0;
                PreText := GetFilter("Posting Date");

            end;

            trigger OnAfterGetRecord()
            begin

                clear("Debit Amount");
                Clear("Credit Amount");

                if Amount > 0 then
                    "Debit Amount" := Amount
                else
                    if Amount < 0 then
                        "Credit Amount" := Abs(Amount);




                TotalCredit += "Credit Amount";
                TotalDebit += "Debit Amount";
                TotalNet += Amount;
                if "G/L Account No." <> '' then
                    GLAccountCount += 1;


            end;
        }
        Dataitem(Totals; Integer)
        {
            DataItemTableView = sorting(Number)
                                   where(Number = const(1));
            column(TotalCreditamt; TotalCredit) { }
            column(TotalDebitamt; TotalDebit) { }
            column(TotalNetamt; TotalNet) { }
            column(TotalCaptionlabel; TotalCaption) { }
        }






    }

    // requestpage
    // {
    //     AboutTitle = 'Teaching tip title';
    //     AboutText = 'Teaching tip content';
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {

    //                 }
    //             }
    // }
    //}



    rendering
    {
        layout(GLReport)
        {
            Type = Excel;
            LayoutFile = 'mymisSpreadsheet.xlsx';
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        TotalCaption := 'Grand Total';
        ReportCaption := 'GENERAL LEDGER CALCULATION REPORT';
    end;

    var
        myInt: Integer;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        TotalNet: Decimal;
        PreText: text[190];
        TotalCaption: Text[200];
        ReportCaption: Text[500];
        CompanyInfo: record "Company Information";
        GLAccountCount: Integer;
}