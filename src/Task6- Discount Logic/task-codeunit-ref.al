codeunit 50168 "yourreferencecheck"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure checkreferencestatus(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)

    begin
        if SalesHeader."Your Reference" = '' then begin
            Error('Can not Release when Your Reference is empty! ');
        end
        else begin
            Message('You can release the document')
        end;

    end;
}