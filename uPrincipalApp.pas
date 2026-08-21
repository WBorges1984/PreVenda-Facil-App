unit uPrincipalApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    ButtonEnviar: TButton;
    procedure ButtonEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.ButtonEnviarClick(Sender: TObject);
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  JSONPedido, JSONItem1: TJSONObject;
  JSONItens: TJSONArray;
begin
  // ATENÇÃO: No Android, 'localhost' ou '127.0.0.1' apontam para o próprio celular!
  // Coloque o IP da sua máquina na rede local (ex: 192.168.0.15)
  Client := TRESTClient.Create('http://SEU_IP_AQUI:9000/pedidos');
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  JSONPedido := TJSONObject.Create;

  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Method := rmPOST;

    // 1. Montando o JSON com a Capa do Pedido
    JSONPedido.AddPair('cliente', 'Cliente Teste');
    JSONPedido.AddPair('total', TJSONNumber.Create(150.50));

    // 2. Montando o Array de Itens do Pedido
    JSONItens := TJSONArray.Create;

    // Criando o primeiro item
    JSONItem1 := TJSONObject.Create;
    JSONItem1.AddPair('produto', '001');
    JSONItem1.AddPair('qtde', TJSONNumber.Create(2));
    JSONItem1.AddPair('vl_unit', TJSONNumber.Create(75.25));

    // Adiciona o item dentro do Array
    JSONItens.AddElement(JSONItem1);

    // Adiciona o Array de itens dentro do JSON principal
    JSONPedido.AddPair('itens', JSONItens);

    // 3. Coloca o JSON finalizado no corpo da requisição
    Request.AddBody(JSONPedido.ToString, ctAPPLICATION_JSON);

    // 4. Dispara a requisição para o servidor Horse!
    try
      Request.Execute;

      // Verifica o código HTTP de retorno (201 é o Created que definimos no Horse)
      if Response.StatusCode = 201 then
        ShowMessage('Sucesso! ' + Response.Content)
      else
        ShowMessage('Erro do Servidor: ' + Response.StatusCode.ToString + sLineBreak + Response.Content);
    except
      on E: Exception do
        ShowMessage('Falha ao conectar no servidor: ' + E.Message);
    end;

  finally
    // Limpando a memória
    JSONPedido.Free;
    Request.Free;
    Response.Free;
    Client.Free;
  end;
end;

end.
