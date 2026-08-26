unit uPrincipalApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FireDAC.Comp.Client, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Generics.Collections, FMX.Objects, FMX.Layouts, FMX.Edit;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    recBottom: TRectangle;
    recLogin: TRectangle;
    Label2: TLabel;
    Rectangle2: TRectangle;
    Image2: TImage;
    EditUsuario: TEdit;
    StyleBook1: TStyleBook;
    Rectangle3: TRectangle;
    Image3: TImage;
    EditSenha: TEdit;
    Label3: TLabel;
    btnLogin: TSpeedButton;
    recBtnLogin: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    procedure btnLoginMouseEnter(Sender: TObject);
    procedure btnLoginMouseLeave(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.btnLoginClick(Sender: TObject);
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  JSONEnvio: TJSONObject;
begin
  if (EditUsuario.Text = '') or (EditSenha.Text = '') then
  begin
    ShowMessage('Preencha usuário e senha!');
    Exit;
  end;

  Client := TRESTClient.Create('http://192.168.100.5:9000/login');
  Client.RaiseExceptionOn500 := False; // Importante para lermos o erro
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  JSONEnvio := TJSONObject.Create;

  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Method := rmPOST;

    // Prepara os dados que o usuário digitou
    JSONEnvio.AddPair('usuario', EditUsuario.Text);
    JSONEnvio.AddPair('senha', EditSenha.Text);
    Request.AddBody(JSONEnvio.ToString, ctAPPLICATION_JSON);

    try
      Request.Execute;

      if Response.StatusCode = 200 then
      begin
        // Login com sucesso!
        ShowMessage('Bem-vindo, ' + EditUsuario.Text + '!');

        // Aqui você esconde a tela de login e mostra a tela do catálogo/carrinho
        // Exemplo:
        // TabControl1.ActiveTab := TabCatalogo;
      end
      else
      begin
        // Erro de usuário ou senha (Erro 401 que devolvemos do servidor)
        //ShowMessage('Acesso Negado: ' + Response.JSONValue.GetValue<string>('mensagem'));
        ShowMessage('Erro do servidor: ' + Response.Content);
      end;
    except
      on E: Exception do
        ShowMessage('Erro de conexão com o servidor: ' + E.Message);
    end;

  finally
    JSONEnvio.Free;
    Request.Free;
    Response.Free;
    Client.Free;
  end;
end;

procedure TForm1.btnLoginMouseEnter(Sender: TObject);
begin
  recBtnLogin.Fill.Color := $FF33AD5E;
end;

procedure TForm1.btnLoginMouseLeave(Sender: TObject);
begin
  recBtnLogin.Fill.Color := $FF1CA54C;
end;

end.
