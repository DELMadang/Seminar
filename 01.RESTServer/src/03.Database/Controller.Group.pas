unit Controller.Group;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Data.DB,
  uDBPool,
  Horse;

implementation

procedure RegisterController;
begin
  THorse.Get('/group',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      var LConnection := TDatabase.GetConnection;
      var LQuery := LConnection.GetQuery;
      try
        LQuery.SQL.Text :=
        'SELECT ' +
        '  USR_ID ' +
        '  , USR_NM ' +
        '  , USR_LVL ' +
        'FROM ' +
        '  USRS ';
        LQuery.Open;

        Res.ContentType('application/json');
        Res.Send(LQuery.ToJSON);
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);

  THorse.Get('/group/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      var LConnection := TDatabase.GetConnection;
      var LQuery := LConnection.GetQuery;
      try
        LQuery.SQL.Text := '''
        SELECT
          USR_ID
          , USR_NM
          , USR_LVL
        FROM
          USRS
        WHERE
          USR_ID = :USR_ID
        ''';
        LQuery.Params.ParamByName('USR_ID').AsString := Req.Params['id'];
        LQuery.Open;

        Res.ContentType('application/json');
        Res.Send(LQuery.ToJSON);
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);
end;

initialization
  RegisterController;
end.
