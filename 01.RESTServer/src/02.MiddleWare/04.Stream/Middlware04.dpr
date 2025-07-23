program Middlware04;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,

  Horse,
  Horse.OctetStream;

begin
  THorse.Use(OctetStream);

  THorse.Get('/stream',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LStream: TFileStream;
    begin
      LStream := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'horse.pdf', fmOpenRead);
      Res.Send<TStream>(LStream);
    end);

  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
