@echo on

for /R .\Source %%f in (*.res *.dfm *.inc) do (
  copy %%f ..\..\lib\dcu\win32\debug
  copy %%f ..\..\lib\dcu\win32\release
  copy %%f ..\..\lib\dcu\win64\debug
  copy %%f ..\..\lib\dcu\win64\release
)

pause