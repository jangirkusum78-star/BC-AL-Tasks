//Task 3 — Create an AL processing codeunit
//Write logic to find items whose inventory is below their minimum stock quantity.

codeunit 50112 "Item stock quanity"
{
    local procedure checkstockinve(var item: Record Item; lowstock: Boolean)
    begin
        lowstock := false;


        if item.FindSet() then
            repeat
                item.CalcFields(Inventory);
                if item.Inventory < item.Minimum_Stock_Quantity then begin
                    lowstock := true;
                    Message(
                        'Item No.: %1\Description: %2\Inventory: %3\Minimum Stock: %4',
                        item."No.",
                        item.Description,
                        item.Inventory,
                        item."Minimum_Stock_Quantity");
                end;

            until item.next() = 0;

        if not lowstock then
            Message('No low stock found');

    end;

}