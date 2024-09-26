tableextension 50000 UserSetupNavNab extends "User Setup"
{
    fields
    {
        field(50000; AllowSystemTablesNavNab; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow System Tables';
            ToolTip = 'Check this box to allow the user to see system tables in Configuration Packages.';
        }
    }
}