/* task - if amount is lower than 30000 then set priority tolow , if it is between 100000 and 60000 then
its medium if it is higher then it high as these are not working normally so created an action to trigger
the logic */


tableextension 50103 "soextnew" extends "Sales Header"
{
    fields
    {
        field(50101; "Priority"; enum Priority)
        {
            DataClassification = CustomerContent;
        }

    }


}