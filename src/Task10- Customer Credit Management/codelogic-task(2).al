codeunit 50122 "Check Risk rating"
{
    procedure checkriskrating(var customer: Record Customer)
    var
        custbalance: Decimal;
    begin
        Customer.CalcFields(Balance);
        custbalance := customer.Balance;
        if custbalance >= 500000 then begin
            customer."Risk Rating" := customer."Risk Rating"::High
        end
        else if (custbalance >= 100000) and (custbalance < 500000)
        then begin
            customer."Risk Rating" := customer."Risk Rating"::Medium
        end
        else
            customer."Risk Rating" := customer."Risk Rating"::Low;
        customer.Modify();

    end;


}
// now adding this logic in an action  in customer card page