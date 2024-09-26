pageextension 50001 ConfigPackageSubformNavNab extends "Config. Package Subform"
{
    layout
    {
        modify("Table ID")
        {
            // The Lookup on the page overrides the Lookup from the table 
            trigger OnLookup(var Text: Text): Boolean
            var
                AllObj: Record AllObj;
            begin
                LookupObject(AllObj."Object Type"::Table, Rec."Table ID");
                if Rec."Table ID" <> 0 then
                    Rec.Validate("Table ID");
            end;
        }
    }

    /// <summary>
    /// This procedure is a copy of the LookupObject procedure in the codeunit 8617 "Config. Validate Management"
    /// Ideally Microsoft should add an event so we can subscribe to it and add our own logic.
    /// This is a demo app anyway, so I'm just going to copy the code here ;)
    /// </summary>
    local procedure LookupObject(ObjectType: Integer; var ObjectID: Integer)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Objects: Page Objects;
        UnrestrictedConfPack: Codeunit UnrestrictedConfPackNavNab;
    begin
        Clear(Objects);
        AllObjWithCaption.FilterGroup(2);
        AllObjWithCaption.SetRange("Object Type", ObjectType);
        // Check if the user is allowed to access system tables
        // or implement your own logic here...
        if not UnrestrictedConfPack.CheckUserIsAllowedToAccessSystemTable() then
            AllObjWithCaption.SetFilter("Object ID", '..%1|%2|%3', 1999999999, DATABASE::"Permission Set", DATABASE::Permission);
        AllObjWithCaption.FilterGroup(0);
        Objects.SetTableView(AllObjWithCaption);
        Objects.LookupMode := true;
        if Objects.RunModal() = Action::LookupOK then begin
            Objects.GetRecord(AllObjWithCaption);
            ObjectID := AllObjWithCaption."Object ID";
        end;
    end;
}