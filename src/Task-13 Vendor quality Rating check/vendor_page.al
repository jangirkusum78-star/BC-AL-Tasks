pageextension 50102 "vendor page" extends "Vendor Card"
{
    layout
    {
        addafter(Transporter)
        {
            field(Quality_Rating; Rec.Quality_Rating)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}