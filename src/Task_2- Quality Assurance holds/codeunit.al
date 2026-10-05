codeunit 50164 "COAPostingSubscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure HandleCOAStatusPost(var PurchaseHeader: Record "Purchase Header")



    begin
        if PurchaseHeader.Receive then begin
            if (PurchaseHeader."COA(status)" = PurchaseHeader."COA(status)"::Blank)
                or
               (PurchaseHeader."COA(status)" = PurchaseHeader."COA(status)"::Missing) then begin
                Error('Cannot post receipt for Purchase Order %1 because the Certificate of Analysis (COA) Status is missing or blank.', PurchaseHeader."No.");

            end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInsertPostedHeaders', '', false, false)]
    // <-- Note the 'true' at the end to allow skipping fields!
    local procedure CopyCOAStatusToReceipt(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        if PurchaseHeader.Receive then begin
            PurchRcptHeader."COA(status)" := PurchaseHeader."COA(status)";
        end;
    end;






}
// TASK 4: Data Flow Mapping
// Copies the field safely if the validation above passe==========================================
// {
//    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInsertPostedHeaders', '', false, false, true)] 
//    // <-- Note the 'true' at the end to allow skipping fields!
//     local procedure CopyCOAStatusToReceipt(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
//     begin
//         if PurchaseHeader.Receive then begin
//             PurchRcptHeader."COA(status)" := PurchaseHeader."COA(status)";
//         end;
//     end;
// }



/*If a user tries to click Post -> Receive on a Purchase Order, your code must check the "COA Status". 
If it is set to Missing or Blank, throw an error message stopping the posting process: "Cannot receive this
 order because the Certificate of Analysis (COA) status is missing */
// COA - certificate of analysis