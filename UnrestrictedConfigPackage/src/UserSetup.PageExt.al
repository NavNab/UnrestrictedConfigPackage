pageextension 50000 UserSetupNavNab extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field(AllowSystemTablesNavNab; Rec.AllowSystemTablesNavNab)
            {
                ApplicationArea = All;
            }
        }
    }
}
