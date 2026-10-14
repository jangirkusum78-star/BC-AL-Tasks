// codeunit 50105 "priority check"
// {

//     local procedure prioritychecklist(var Salesheader: Record "Sales Header")
//     begin
//         if Salesheader.Amount <= 30000 then begin
//             Salesheader.priority := Salesheader.priority::low;
//         end
//         else if (Salesheader.Amount >= 50000) and (Salesheader.Amount <= 100000) then begin
//             Salesheader.priority := Salesheader.priority::medium;
//         end
//         else if Salesheader.Amount >= 150000 then begin
//             Salesheader.priority := Salesheader.priority::high;
//         end;
//         Salesheader.modify();
//     end;

// }
codeunit 50105 "Priority Check"
{
    procedure CalculatePriority(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                TotalAmount += SalesLine."Line Amount";
            until SalesLine.Next() = 0;

        if TotalAmount <= 30000 then
            SalesHeader.Priority := SalesHeader.Priority::Low
        else if (TotalAmount <= 100000) and (TotalAmount >= 60000) then
            SalesHeader.Priority := SalesHeader.Priority::Medium
        else
            SalesHeader.Priority := SalesHeader.Priority::High;

        SalesHeader.Modify();
    end;
}
