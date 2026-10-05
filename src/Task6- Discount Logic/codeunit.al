// codeunit 50178 "VIP Discount Management"
// {
//     [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, 'No.', false, false)]
//     local procedure DisMgmglCalculations(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
//     var
//         customer: Record "Customer";
//         item: Record "Item";
//     begin
//         if Rec.Type <> Rec.Type::Item then
//             exit;
//         if Rec."No." = '' then
//             exit;
//         if customer.Get(Rec."Sell-to Customer No.") then begin
//             if customer."VIP Customer" = True then begin
//                 if item.Get(Rec."No.") then begin
//                     if item.Type = Item.type::Inventory then begin


//                         Rec.Validate("Line Discount %", 15);
//                         Rec.Modify();
//                     end
//                 end;
//             end;
//         end;
//     end;
// }


codeunit 50177 "VIP Discount Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure ApplyVIPDiscountOnAfterValidateNo(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        Customer: Record Customer;
        Item: Record Item;
    begin
        if Rec.Type <> Rec.Type::Item then
            exit;

        if Rec."No." = '' then
            exit;

        // DEBUG POINT 1: If you see this, the event subscriber IS firing successfully!
        Message('Step 1: Event Fired for Item %1', Rec."No.");

        if Customer.Get(Rec."Sell-to Customer No.") then begin
            // DEBUG POINT 2: Shows you if the customer VIP box is active
            Message('Step 2: Customer VIP Status is %1', Customer."VIP Customer");

            if Customer."VIP Customer" = true then begin

                if Item.Get(Rec."No.") then begin
                    // DEBUG POINT 3: Shows you the exact text category code inside SQL
                    Message('Step 3: Item Category is %1', Item."Item Category Code");



                    if item.Type = Item.type::Inventory then begin


                        //if Item."Item Category Code" = 'SPAREPARTS' then begin

                        // Apply the discount
                        Rec.Validate("Line Discount %", 15);

                        // DEBUG POINT 4: Confirming the assignment completed
                        Message('Success! 15%% discount injected.');
                    end;
                end;

            end;
        end;
    end;
}
