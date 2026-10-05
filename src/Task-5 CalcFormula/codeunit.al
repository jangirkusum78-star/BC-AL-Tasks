codeunit 50175 "calculatesalesinventory"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure CheckInvenoryStatus(var SalesHeader: Record "Sales Header");

    var
        salesline: Record "Sales Line";
        item: Record "Item";
        OutOfStockErr: Label 'Cannot release Order %1 because Item %2 (%3) is out of stock (Current Inventory: %4).';



    begin
        salesline.SetRange("Document Type", SalesHeader."Document Type");
        salesline.setrange("Document No.", SalesHeader."No.");
        salesline.setrange(Type, salesline.Type::Item);
        // condition logic
        if salesline.FindSet() then begin
            repeat
                if item.Get(salesline."No.") then begin
                    item.CalcFields(Inventory);
                    if item.Inventory <= 0 then
                        Error(OutOfStockErr, SalesHeader."No.", SalesLine."No.", SalesLine.Description, Item.Inventory);

                end;
            until salesline.Next() = 0;

        end;

    end;
}