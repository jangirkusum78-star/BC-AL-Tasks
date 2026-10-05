// tableextension 50162 "Postedpurchheader" extends "Posted Purch. Rcpt. Header"
// {
//     fields
//     {
//         field(50112; "COA(status)"; Enum "COA(Status)")
//         {
//             Caption = 'COA(status)';
//             DataClassification = CustomerContent;
//         }

//     }
// }
tableextension 50112 "PurchRcptHeaderExt" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50100; "COA(status)"; Enum "COA(Status)")
        {
            Caption = 'COA(status)';
            DataClassification = CustomerContent;
        }
    }
}