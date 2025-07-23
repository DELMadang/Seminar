program Middlware01;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Jhonson;

begin
  // 미들웨어 등록
  THorse.Use(Jhonson());

  // 라우터에 등록한다
  THorse.Get('/hello',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LResult: TJSONObject;
    begin
      LResult := TJSONObject.Create;
      LResult.AddPair('response', 'Hello, World');
      Res.Send<TJSONObject>(LResult);
    end);

  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
