unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,

  IdContext,
  IdHttp,
  IdCustomHttpServer,
  IdHttpServer;

type
  TfrmMain = class(TForm)
    ePort: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    btnExecute: TButton;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FServer: TIdHttpServer;

    procedure Start(const APort: Integer = 8080);
    procedure Stop;
    procedure TriggerCommandGet(AContext: TIdContext; ARequestInfo:
      TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  Winapi.ShellAPI;

{ TForm3 }

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  FServer := TIdHttpServer.Create(Self);
end;

destructor TfrmMain.Destroy;
begin
  FServer.Active := False;
  FServer.Free;

  inherited;
end;

procedure TfrmMain.btnExecuteClick(Sender: TObject);
begin
  var LURL := Format('http://localhost:%d/hello', [FServer.Bindings[0].Port]);
  ShellExecute(0, 'open', PChar(LURL), nil, nil, SW_SHOW);
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  Start;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  Stop;
end;

procedure TfrmMain.Start(const APort: Integer);
begin
  FServer.Bindings.Clear;

  with FServer.Bindings.Add do
  begin
    IP := '0.0.0.0';
    Port := APort;
  end;

  FServer.OnCommandGet := TriggerCommandGet;
  FServer.Active := True;
end;

procedure TfrmMain.Stop;
begin
  FServer.Active := False;
end;

procedure TfrmMain.TriggerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if SameText(ARequestInfo.URI, '/hello') then
  begin

    AResponseInfo.ContentType := 'application/json';
    AResponseInfo.ContentText := '{"response": "Hello, world!"}';
  end
  else
  if SameText(ARequestInfo.URI, '/hello2') then
  begin
    AResponseInfo.ContentType := 'application/json';
    AResponseInfo.ContentText := '{"response": "Hello2, world!"}';
  end
  else
  if SameText(ARequestInfo.URI, '/hello3') then
  begin
    AResponseInfo.ContentType := 'application/json';
    AResponseInfo.ContentText := '{"response": "Hello3, world!"}';
  end;
end;

end.
