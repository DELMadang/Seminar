unit uMain;

interface

uses
  Winapi.Windows,

  System.SysUtils,
  System.Classes,
  System.Net.HttpClient,

  Data.DB,
  Datasnap.DBClient,
  Datasnap.Provider,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,

  JsonDataObjects;

type
  TfrmMain = class(TForm)
    mtCustomer: TClientDataSet;
    dsCustomer: TDataSource;
    DBGrid1: TDBGrid;
    btnQuery: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    eUserID: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    btnInsert: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    HttpClient: THttpClient;

    procedure CreateDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TForm4 }

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  HttpClient := THttpClient.Create;
  CreateDataSet;
end;

destructor TfrmMain.Destroy;
begin
  HttpClient.Free;

  inherited;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox('현재 자료를 삭제하시겠습니까?', '확인', MB_ICONEXCLAMATION + MB_YESNO) <> ID_YES then
    Exit;

  // 서버를 삭제하고
  var LUserID := mtCustomer.FieldByName('USR_ID').AsString;
  var LResponse := HttpClient.Delete(Format('http://localhost:9000/user/%s', [LUserID]));

  // 성공하면 클라이언트도 삭제
  if LResponse.StatusCode = 200 then
    mtCustomer.Delete;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
  mtCustomer.Edit;
end;

procedure TfrmMain.btnInsertClick(Sender: TObject);
begin
  mtCustomer.Append;
end;

procedure TfrmMain.CreateDataSet;
begin
  with mtCustomer do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('USR_ID', ftString, 20, True);
    FieldDefs.Add('USR_NM', ftString, 20, True);
    FieldDefs.Add('USR_LVL', ftInteger, 0, False);

    CreateDataSet;
  end;
end;

procedure TfrmMain.btnQueryClick(Sender: TObject);
begin
  var LResponse := HttpClient.Get('http://localhost:9000/user');
  if LResponse.StatusCode <> 200 then
    Exit;


  var LJSON := TJSONArray.ParseFromStream(LResponse.ContentStream) as TJSONArray;
  try
    mtCustomer.DisableControls;
    mtCustomer.EmptyDataSet;

    for var i := 0 to LJSON.Count-1 do
    begin
      mtCustomer.Append;
      mtCustomer.FieldByName('USR_ID').AsString := LJSON[i].S['usr_id'];
      mtCustomer.FieldByName('USR_NM').AsString := LJSON[i].S['usr_nm'];
      mtCustomer.FieldByName('USR_LVL').AsString := LJSON[i].S['usr_lvl'];
      mtCustomer.Post;
    end;

    mtCustomer.EnableControls;
  finally
    LJson.Free;
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  var LJSON := TJSONObject.Create;
  var LStream := TMemoryStream.Create;

  LJSON.S['usr_id'] := mtCustomer.FieldByName('USR_ID').AsString;
  LJSON.S['usr_nm'] := mtCustomer.FieldByName('USR_NM').AsString;
  LJSON.I['usr_lvl'] := mtCustomer.FieldByName('USR_LVL').AsInteger;

  LJSON.SaveToStream(LStream);
  LStream.Position := 0;

  var LResponse: IHTTPResponse;
  try
    case mtCustomer.State of
    dsEdit:
      begin
        LResponse := HttpClient.Put('http://localhost:9000/user/' + LJSON.S['usr_id'], LStream);
      end;
    dsInsert:
      begin
        LResponse := HttpClient.Post('http://localhost:9000/user', LStream);
      end;
    end;

    if LResponse.StatusCode = 200 then
      mtCustomer.Post
    else
      mtCustomer.Cancel;
  finally
    LStream.Free;
    LJSON.Free;
  end;
end;

end.
