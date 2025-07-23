program Middlware05;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,

  Horse,
  Horse.GBSwagger;

type
  TUser = class
  private
    FID: Double;
    FName: String;
    FLastName: string;
  public
    property ID: Double read FID write FID;
    property Name: String read FName write FName;
    property LastName: string read FLastName write FLastName;
  end;

  TAPIError = class
  private
    FError: string;
  public
    property Error: string read FError write FError;
  end;

var
  App: THorse;

begin
  App := THorse.Create;

  // Access http://localhost:9000/swagger/doc/html
  App.Use(HorseSwagger);

  APP.Get('/user',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
    end);

  APP.Post('user',
    procedure (Req: THorseRequest; Resp: THorseResponse; Next: TProc)
    begin
    end);

  APP.Delete('user',
    procedure (Req: THorseRequest; Resp: THorseResponse; Next: TProc)
    begin
    end);

Swagger
    .Info
      .Title('Database CRUD Sample')
      .Description('API Horse')
      .Contact
        .Name('시골프로그래머')
        .Email('civilian7@email.com')
        .URL('https://cafe.naver.com/delmadang')
      .&End
    .&End
    .BasePath('v1')
    .Path('user')
      .Tag('User')
      .GET('List All', 'List All Users')
        .AddResponse(200, 'successful operation')
          .Schema(TUser)
          .IsArray(True)
        .&End
        .AddResponse(400).&End
        .AddResponse(500).&End
      .&End
      .POST('Add user', 'Add a new user')
        .AddParamBody('User data', 'User data')
          .Required(True)
          .Schema('string')
        .&End
        .AddResponse(201, 'Created')
          .Schema(TUser)
        .&End
        .AddResponse(400, 'BadRequest')
          .Schema(TAPIError)
        .&End
        .AddResponse(500).&End
      .&End
      .DELETE('Delete user', 'Delete user')
        .AddParamQuery('userid', 'User ID')
          .Required(True)
          .Schema('string')
        .&End
        .AddResponse(201, 'Deleted')
          .Schema(TUser)
        .&End
        .AddResponse(400, 'BadRequest')
          .Schema(TAPIError)
        .&End
        .AddResponse(500).&End
      .&End
    .&End
  .&End;

  // 9000번 포트를 리스닝한다
  App.Listen(9000);
end.
