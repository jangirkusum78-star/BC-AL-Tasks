
pageextension 50175 "Item Card Inventory Extension" extends "Item Card"

{
    layout
    {



        modify(Inventory)
        {
            Visible = true;
            ApplicationArea = All;
        }
        // We inject the field into the standard "Item" fast tab group
        // addlast(Item)
        // {
        //     field(Inventory; Rec.Inventory)
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the total live inventory available for this item across all locations.';
        //         // FlowFields should always be non-editable on pages since they are calculated aggregates
        //         Editable = false; 
        //     }
        // }
    }
}
