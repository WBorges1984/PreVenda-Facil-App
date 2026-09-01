unit uPesquisaProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.DialogService, REST.Client, System.JSON, REST.Types;

type
  TfrmPesquisaProduto = class(TForm)
    layTop: TLayout;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Image1: TImage;
    Layout3: TLayout;
    Label1: TLabel;
    Layout1: TLayout;
    EditBusca: TEdit;
    Layout4: TLayout;
    ButtonBuscar: TButton;
    ListViewResultados: TListView;
    procedure ButtonBuscarClick(Sender: TObject);
    procedure ListViewResultadosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaProduto: TfrmPesquisaProduto;

implementation

{$R *.fmx}

uses uBalcao;

procedure TfrmPesquisaProduto.ButtonBuscarClick(Sender: TObject);
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  JSONArray: TJSONArray;
  JSONProduto: TJSONObject;
  I: Integer;
  Item: TListViewItem;
begin
  Client := TRESTClient.Create('http://192.168.100.7:9000/produtos');
  //Client := TRESTClient.Create('http://10.1.1.107:9000/produtos');
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);

  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Method := rmGET;

    // Se o vendedor digitou algo, envia como parâmetro na URL
    if EditBusca.Text <> '' then
      Request.AddParameter('busca', EditBusca.Text);

    Request.Execute;

    if Response.StatusCode = 200 then
    begin
      JSONArray := Response.JSONValue as TJSONArray;

      ListViewResultados.BeginUpdate;
      try
        ListViewResultados.Items.Clear;

        for I := 0 to JSONArray.Count - 1 do
        begin
          JSONProduto := JSONArray.Items[I] as TJSONObject;
          Item := ListViewResultados.Items.Add;

          // No ListView da pesquisa, usamos o layout padrão (Text e Detail)
          Item.Text := JSONProduto.GetValue<string>('descricao');
          Item.Detail := 'Cód: ' + JSONProduto.GetValue<string>('codigo') +
                         ' | R$ ' + FormatFloat(',0.00', JSONProduto.GetValue<Double>('preco'));

          // 💡 O PULO DO GATO: Guardamos os dados brutos ESCONDIDOS no item
          // para usar na hora que o vendedor clicar e mandar pro carrinho!
          Item.Data['codigo'] := JSONProduto.GetValue<string>('codigo');
          Item.Data['unidade'] := JSONProduto.GetValue<string>('unidade');
          Item.Data['preco'] := JSONProduto.GetValue<Double>('preco').ToString;
        end;
        frmBalcao.imgBgList.Visible := false;
      finally
        ListViewResultados.EndUpdate;

      end;
    end
    else
    begin
      ShowMessage(Response.Content);
    end;
  finally
    Request.Free;
    Response.Free;
    Client.Free;
  end;
end;



procedure TfrmPesquisaProduto.ListViewResultadosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
TDialogService.InputQuery('Quantidade', ['Informe a quantidade desejada:'], ['1'],
    procedure(const AResult: TModalResult; const AValues: array of string)
    var
      QtdDigitada: Integer;
    begin
      if AResult = mrOk then
      begin
        if not TryStrToInt(AValues[0], QtdDigitada) then
          QtdDigitada := 1;

        frmBalcao.AdicionarItemNoCarrinho(
          AItem.Data['codigo'].AsString,
          AItem.Text,
          AItem.Data['unidade'].AsString,
          QtdDigitada,
          StrToFloat(AItem.Data['preco'].AsString)
        );

        Self.Close;
      end;
    end);
end;

end.
