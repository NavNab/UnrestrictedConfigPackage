codeunit 50000 UnrestrictedConfPackNavNab
{
    internal procedure CheckUserIsAllowedToAccessSystemTable(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup.AllowSystemTablesNavNab);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Config. Management", OnAfterIsSystemTable, '', false, false)]
    local procedure "Config. Management_OnAfterIsSystemTable"(TableID: Integer; var Result: Boolean)
    begin
        Result := not CheckUserIsAllowedToAccessSystemTable();
    end;
}