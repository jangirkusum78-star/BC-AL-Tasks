// pageextension 50104 "so-ext" extends "Sales Order"
// {
//     layout
//     {
//         addafter("Due Date")
//         {
//             field(Priority; Rec.Priority)
//             {
//                 ApplicationArea = All;
//                 StyleExpr = prioritystyle;

//             }
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }
//     var
//         prioritystyle: Text;

//     trigger OnAfterGetRecord()
//     begin
//         case
//             rec.Priority of
//             rec.Priority::High:
//                 prioritystyle := 'Strong';
//             rec.Priority::Medium:
//                 prioritystyle := 'Attention';
//             rec.Priority::Low:
//                 prioritystyle := 'Unfavourable';

//         end;


//         // PriorityStyle := 'Standard';

//         // if Rec."Priority" = Rec."Priority"::High then
//         //     prioritystyle := 'Strong';

//     end;

//     // var
//     //     prioritystyle: Text;
// }
pageextension 50104 "SO-Ext" extends "Sales Order"
{
    layout
    {
        addafter("Due Date")
        {
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
                StyleExpr = PriorityStyle;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(CalculatePriority)
            {
                ApplicationArea = All;
                Caption = 'Calculate Priority';
                Image = Calculate;

                trigger OnAction()
                var
                    PriorityCheck: Codeunit "Priority Check";
                begin
                    PriorityCheck.CalculatePriority(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        PriorityStyle: Text;

    trigger OnAfterGetRecord()
    begin
        SetPriorityStyle();
    end;

    local procedure SetPriorityStyle()
    begin
        PriorityStyle := 'Standard';

        case Rec.Priority of
            Rec.Priority::High:
                PriorityStyle := 'Strong';

            Rec.Priority::Medium:
                PriorityStyle := 'Attention';

            Rec.Priority::Low:
                PriorityStyle := 'Unfavorable';
        end;
    end;
}
