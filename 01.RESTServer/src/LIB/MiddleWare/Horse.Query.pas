unit Horse.Query;

interface

uses
  System.SysUtils,
  System.JSON,

  Data.DB,
  Horse,
  DataSet.Serialize;

procedure Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LContent: TObject;
  LJA: TJSONArray;
  LOldCaseName: TCaseNameDefinition;
begin
  Next;

  LContent := Res.Content;

  if Assigned(LContent) and LContent.InheritsFrom(TDataSet) then
  begin
    LOldCaseName := TDataSetSerializeConfig.GetInstance.CaseNameDefinition;
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndLower;

    try
      LJA := TDataSet(LContent).ToJSONArray;
    finally
      TDataSetSerializeConfig.GetInstance.CaseNameDefinition := LOldCaseName;
    end;
  end
  else
    Exit;

  if Assigned(LJA) then
  begin
    Res.Send(LJA.ToString);
    FreeAndNil(LJA);
  end
  else
    Res.Send('[]');
end;

end.
