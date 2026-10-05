pageextension 50166 "POextnsn" extends "Purchase Order"
{
    layout
    {
        // adding custom field
        addafter("Order Date")
        {
            field("PO-expiry-date"; Rec."PO-expiry-date")
            {
                ApplicationArea = All;
                //Editable = false;

            }
        }

        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                vendor: Record vendor;
            begin
                rec."Order Date" := WorkDate();
                if vendor.Get(Rec."Buy-from Vendor No.") then begin
                    if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Registered then
                        rec."PO-expiry-date" := rec."Order Date" + 90
                    else if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Unregistered then
                        rec."PO-expiry-date" := rec."Order Date" + 30;
                    if Rec.Modify() then;

                end
            end;
        }
        modify("Order Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                vendor: Record vendor;
            begin
                rec."Order Date" := WorkDate();
                if vendor.Get(Rec."Buy-from Vendor No.") then begin
                    if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Registered then
                        rec."PO-expiry-date" := rec."Order Date" + 90
                    else if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Unregistered then
                        rec."PO-expiry-date" := rec."Order Date" + 30;

                end
            end;
        }

    }
}
//         // modifying existing field
//         modify("Buy-from Vendor No.")
//         {
//             trigger OnAfterValidate()
//             var
//                 vendor: Record "Vendor";
//             begin
//                 if vendor.Get(Rec."GST Vendor Type") then begin

//                     Case
//                        vendor."GST Vendor Type" of
//                         vendor."GST Vendor Type"::Unregistered:
//                             Rec."PO-expiry-date" := CalcDate('90D',Today());
//                         vendor."GST Vendor Type"::Registered:
//                             Rec."PO-expiry-date" := CalcDate('30D', Today())
//                         else
//                             Error('Invalid GST Vendor Type for Vendor %1.', Vendor."No.");

//                     End;
//                 end
//                 else begin

//                 end;
//                 CurrPage.Update(true);

//             end;

//         }





//     }


//     actions
//     {
//         // Add changes to page actions her
//     }
//     // trigger OnAfterGetRecord()
//     // var
//     //     vendor: Record "Vendor";
//     // begin
//     //     if vendor.Get(Rec."No.") then begin
//     //         //     if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Import then begin
//     //         Rec."PO-expiry-date" := CalcDate('90d');
//     //     end;
//     //     if vendor."GST Vendor Type" = vendor."GST Vendor Type"::Registered then begin
//     //         Rec."PO-expiry-date" := CalcDate('30d');
//     //     end
//     //     else
//     //         Error('')
//     // end
//     // case vendor."GST Vendor Type" of
//     //     vendor."GST Vendor Type"::Import:
//     //         Rec."PO-expiry-date" := CalcDate('<+90D>', Today);

//     //     vendor."GST Vendor Type"::Registered: // Note: BC standard field uses 'Registered', change to 'Reserved' if it is a custom option
//     //         Rec."PO-expiry-date" := CalcDate('<+30D>', Today);

//     //     else
//     //         // 3. Throw a meaningful error if it matches neither type
//     //         Error('Invalid GST Vendor Type for Vendor %1. Must be Import or Registered.', Vendor."No.");
//     // end;

//     //     // 4. Persist the change to the database
//     //     Rec.Modify();
//     // end;

//     // end;






