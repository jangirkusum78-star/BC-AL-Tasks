tableextension 50167 "sales-order" extends "Sales Header"
{
    fields
    {
        field(50117; "CreditStatus"; Enum "credit-status")
        {
            DataClassification = CustomerContent;
        }
        field(50118; "Credit-risk-score"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    //    var
    //         myInt: Integer;
}
/* automated credit-lock system that calculates a customer's financial risk, blocks salespeople from 
posting orders that exceed credit limits, and saves a permanent risk flag in the ledger history for 
executive reporting.*/
