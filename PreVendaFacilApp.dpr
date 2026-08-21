program PreVendaFacilApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipalApp in 'uPrincipalApp.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
