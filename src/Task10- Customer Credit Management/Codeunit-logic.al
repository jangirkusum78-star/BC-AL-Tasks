codeunit 50127 "Customer Credit Management"
{
    procedure CheckCreditLimit(var SalesHeader: Record "Sales Header")

    var
        Customer: Record "Customer";
        CustomerBalance: Decimal;
        CreditLimit: Decimal;
        SalesOrderAmount: Decimal;
        Salesline: record "Sales Line";
        Totalexposure: Decimal;


    begin
        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.CalcFields(Balance);
        CreditLimit := Customer."Credit Limit (LCY)";
        CustomerBalance := Customer.Balance;
        // let find the total order in sales line by getting document tpe, documnet no
        Salesline.SetRange("Document Type", SalesHeader."Document Type");
        Salesline.SetRange("Document No.", SalesHeader."No.");
        // find the sale line add the line maount into Salesorderamount var until there are no more lines
        if Salesline.FindSet() then
            repeat
                SalesOrderAmount += Salesline."Line Amount"
            until Salesline.Next() = 0;
        // calculating total exposure
        Totalexposure := CustomerBalance + SalesOrderAmount;
        // apply the logic
        if Totalexposure >= CreditLimit then begin
            SalesHeader."Credit Check Status" := SalesHeader."Credit Check Status"::"Approval Required";
        end
        else begin
            SalesHeader."Credit Check Status" := SalesHeader."Credit Check Status"::"Passed";
        end;
        // when we are  making changes in  the header table then we have to modify them
        SalesHeader.modify();


    end;
}