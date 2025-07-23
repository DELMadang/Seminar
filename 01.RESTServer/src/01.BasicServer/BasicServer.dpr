program BasicServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Horse;

begin
  // 라우터에 등록한다
  THorse.Get('/hello',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.ContentType('application/json');
      Res.Send('{"response": "Hello World!"}');
    end);

  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
