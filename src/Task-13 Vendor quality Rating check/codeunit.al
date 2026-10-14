codeunit 50103 "Po validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeReleasePurchaseDoc, '', false, false)]
    local procedure poreleasevalidation(var PurchaseHeader: Record "Purchase Header"; PreviewMode: boolean; var SkipCheckReleaseRestrictions: Boolean;
        var IsHandled: Boolean;
        SkipWhseRequestOperations: Boolean)
    var
        Vendor: Record Vendor;
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        if not Vendor.get(PurchaseHeader."Buy-from Vendor No.") then
            Error('Vendor %1 could not found', PurchaseHeader."Buy-from Vendor No.");

        if (Vendor.Quality_Rating < 3) or
                   (Vendor.Quality_Rating > 5) then
            Error(
                'Release blocked. PO: %1, Vendor: %2, Rating: %3. A rating from 3 to 5 is required.',
                PurchaseHeader."No.",
                Vendor."No.",
                Vendor.Quality_Rating);




    end;
}