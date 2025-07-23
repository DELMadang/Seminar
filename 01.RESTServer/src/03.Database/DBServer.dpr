program DBServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  System.JSON,

  Data.DB,
  uDBPool,

  Horse;

begin
  // 전체 조회
  THorse.Get('/user',
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
        ''';
        LQuery.Open;

        Res.ContentType('application/json');
        Res.Send(LQuery.ToJSON);
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);

  // 단건 조회
  THorse.Get('/user/:id',
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

  // 삭제
  THorse.Delete('/user/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      var LConnection := TDatabase.GetConnection;
      var LQuery := LConnection.GetQuery;
      try
        LQuery.SQL.Text := '''
        DELETE
        FROM
          USRS
        WHERE
          USR_ID = :USR_ID
        ''';
        LQuery.Params.ParamByName('USR_ID').AsString := Req.Params['id'];
        LQuery.ExecSQL;

        Res.ContentType('application/json');
        Res.Send('{"result": "OK"}');
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);

  // 등록
  THorse.Post('/user',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      var LConnection := TDatabase.GetConnection;
      var LQuery := LConnection.GetQuery;
      try
        LQuery.SQL.Text := '''
        INSERT INTO USRS
        (
          USR_ID
          , USR_PW
          , USR_NM
          , USR_LVL
        )
        VALUES
        (
          :USR_ID
          , :USR_PW
          , :USR_NM
          , :USR_LVL
        )
        ''';

        var LJSON := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
        LQuery.Params.ParamByName('USR_ID').AsString := LJSON.GetValue<string>('usr_id');
        LQuery.Params.ParamByName('USR_PW').AsString := '1234';
        LQuery.Params.ParamByName('USR_NM').AsString := LJSON.GetValue<string>('usr_nm');
        LQuery.Params.ParamByName('USR_LVL').AsInteger := LJSON.GetValue<Integer>('usr_lvl');
        LQuery.ExecSQL;
        LJSON.Free;
        Res.ContentType('application/json');
        Res.Send(LQuery.ToJSON);
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);

  // 수정
  THorse.Put('/user/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      var LConnection := TDatabase.GetConnection;
      var LQuery := LConnection.GetQuery;
      try
        LQuery.SQL.Text := '''
        UPDATE USRS
        SET
          USR_NM = :USR_NM
          , USR_LVL = :USR_LVL
        WHERE
          USR_ID = :USR_ID
        ''';

        var LJSON := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
        LQuery.Params.ParamByName('USR_ID').AsString := Req.Params['id'];
        LQuery.Params.ParamByName('USR_NM').AsString := LJSON.GetValue<string>('usr_nm');
        LQuery.Params.ParamByName('USR_LVL').AsInteger := LJSON.GetValue<Integer>('usr_lvl');
        LQuery.ExecSQL;
        LJSON.Free;

        Res.ContentType('application/json');
        Res.Send(LQuery.ToJSON);
      finally
        LQuery.Free;
        LConnection.Free;
      end;
    end);

  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
