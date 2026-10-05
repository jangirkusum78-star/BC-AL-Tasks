// tableextension 50148 "sales extnsn" extends "Sales Header"
// {
//     fields

//     {
//         Field(50112; "cum_revenue"; Decimal)
//         {
//             Caption = 'cumalative revenue';
//             FieldClass = FlowField;
//             Editable = false;
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Including VAT"  where("Customer No." = field("No.")));

//         }
//     }

//     // keys
//     // {
//     //     // Add changes to keys here
//     // }

//     // fieldgroups
//     // {
//     //     // Add changes to field groups here
//     // }

//     var
//         myInt: Integer;
//     //         trigger ()
//     //         Begin  
//     //              Rec.CalcFields("cum_revenue");
//     //              Messagge('This customer has generated %1 in total sales!', Rec."cum_revenue")
//     //         End;
// }