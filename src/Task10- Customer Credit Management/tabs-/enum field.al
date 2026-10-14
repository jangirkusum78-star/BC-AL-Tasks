enum 50123 "Credit Check Status"
{
    Extensible = true;

    value(0; "Not Checked ")
    {
        Caption = 'Not Checked';
    }
    value(1; "Passed")
    {
        Caption = 'Passed';
    }
    value(2; "Approval Required")
    {
        Caption = 'Approval Required';
    }
    value(3; "Rejected")
    {
        Caption = 'Rejected';
    }
}