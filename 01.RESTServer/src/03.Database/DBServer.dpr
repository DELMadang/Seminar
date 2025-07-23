program DBServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Data.DB,
  uDBPool,
  Horse,
  Controller.Group in 'Controller.Group.pas',
  Controller.User in 'Controller.User.pas';

begin
  // 9000번 포트를 리스닝한다
  THorse.Listen(9000);
end.
