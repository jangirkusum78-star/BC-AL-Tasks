/* Credit status limit task over view create a field  credit status block(enum) in sales header then
 if customer credit limit is greater than 10 and balance lcy is greater then 150000 than thies field w
 ill automatically set to blocked*/



codeunit 50185 "Sales status checklist"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, 'No.', false, false)]
    local procedure checkcustomerbalance(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Customer: Record "Customer";
    begin
        if Rec."Sell-to Customer No." <> '' then begin
            if Customer.get(Rec."Sell-to Customer No.") then
                if (Customer."Credit Amount (LCY)" > 10) Or (Customer."Balance (LCY)" >= 50000) then begin
                    Rec."Credit block status" := Rec."Credit block status"::Blocked;
                end;
        end


    end;
}