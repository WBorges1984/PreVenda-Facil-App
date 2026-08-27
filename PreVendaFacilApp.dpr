program PreVendaFacilApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uBalcao in 'uBalcao.pas' {frmBalcao},
  uConfiguracao in 'uConfiguracao.pas' {frmConfiguracao},
  uPesquisaProduto in 'uPesquisaProduto.pas' {frmPesquisaProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBalcao, frmBalcao);
  Application.CreateForm(TfrmPesquisaProduto, frmPesquisaProduto);
  Application.Run;
end.
