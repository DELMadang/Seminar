program Middlware04;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,

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
      Res.Send<TStream>(LStream).ContentType('application/pdf');
    end);

  THorse.Get('/download/:filename',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LPath: string;
      LStream: TFileStream;
    begin
      LPath := TPath.Combine(ExtractFilePath(ParamStr(0)), Req.Params['filename']);
      if TFile.Exists(LPath) then
      begin
        LStream := TFileStream.Create(LPath, fmOpenRead);
        Res.Send<TStream>(LStream).ContentType('application/pdf');
      end
      else
      begin
        Res.Status(THTTPStatus.NotFound);
      end;
    end);

  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
