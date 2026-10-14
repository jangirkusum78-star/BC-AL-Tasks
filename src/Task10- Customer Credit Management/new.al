//  - modify comment action on purchase order so that when you insert any comment it should not exceed 
//the length more than 15 characters
pageextension 50111 "Purch Comment Sheet Ext" extends "Purch. Comment Sheet"
{
    layout
    {
        modify(Comment)
        {
            trigger OnAfterValidate()
            begin
                Rec.Comment := CopyStr(Rec.Comment, 1, 15);
            end;
        }
    }
}
