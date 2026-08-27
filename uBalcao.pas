unit uBalcao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Actions, FMX.ActnList;

type
  TfrmBalcao = class(TForm)
    layTop: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Image1: TImage;
    Label1: TLabel;
    layContent: TLayout;
    Layout1: TLayout;
    layDesc: TLayout;
    Label2: TLabel;
    layUni: TLayout;
    Label3: TLabel;
    layVlUni: TLayout;
    Label4: TLabel;
    layTot: TLayout;
    Label5: TLabel;
    layQTD: TLayout;
    Label6: TLabel;
    ActionList1: TActionList;
    ListView1: TListView;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FBmpCinza, FBmpBranco: TBitmap;
  public
    { Public declarations }
    procedure AdicionarItemNoCarrinho(const ACodigo, ADescricao, AUnidade: string; AQtd: Integer; AVlUnitario: Double);
  end;

var
  frmBalcao: TfrmBalcao;

implementation

{$R *.fmx}

uses uLogin, uPesquisaProduto;

procedure TfrmBalcao.FormCreate(Sender: TObject);
begin
  // Cria os bitmaps sólidos UMA única vez (evita recriar a cada scroll/repaint)
  FBmpCinza := TBitmap.Create(4, 4);
  FBmpCinza.Clear($FFF0F0F0); // Cinza

  FBmpBranco := TBitmap.Create(4, 4);
  FBmpBranco.Clear($FFFFFFFF); // Branco
end;

procedure TfrmBalcao.FormDestroy(Sender: TObject);
begin
  FBmpCinza.Free;
  FBmpBranco.Free;
end;

procedure TfrmBalcao.AdicionarItemNoCarrinho(const ACodigo, ADescricao,
  AUnidade: string; AQtd: Integer; AVlUnitario: Double);
var
  Item: TListViewItem;
  VlTotal: Double;
begin
  // Calcula o total daquele item (Ex: 2 x R$ 10,00 = R$ 20,00)
  VlTotal := AQtd * AVlUnitario;

  ListView1.BeginUpdate;
  try
    Item := ListView1.Items.Add;

    // Preenche o ListView dinamicamente com os dados recebidos
    Item.Data['txtCodigo']  := 'CÓDIGO: ' + ACodigo;
    Item.Data['txtDesc']    := ADescricao;
    Item.Data['txtUn']      := AUnidade;
    Item.Data['txtQTD']     := IntToStr(AQtd);

    // Formata os números para o padrão de dinheiro (Ex: 10,00)
    Item.Data['txtVlUni']   := FormatFloat(',0.00', AVlUnitario);
    Item.Data['txtVlTotal'] := FormatFloat(',0.00', VlTotal);
  finally
    ListView1.EndUpdate;
  end;
end;

procedure TfrmBalcao.Button1Click(Sender: TObject);
begin
  // 1. Verifica se a tela de pesquisa já existe na memória
  if not Assigned(frmPesquisaProduto) then
    Application.CreateForm(TfrmPesquisaProduto, frmPesquisaProduto);

  // 2. Abre a tela de pesquisa por cima do balcão
  frmPesquisaProduto.Show;
  frmPesquisaProduto.EditBusca.Text := '';
  frmPesquisaProduto.ListViewResultados.Items.Clear;
end;

procedure TfrmBalcao.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  Fundo: TListItemImage;
begin
  Fundo := TListItemImage(AItem.Objects.FindDrawable('bgFundo'));
  if Assigned(Fundo) then
  begin
    Fundo.ScalingMode := TImageScalingMode.Stretch;
    if Odd(AItem.Index) then
      Fundo.Bitmap := FBmpCinza
    else
      Fundo.Bitmap := FBmpBranco;
  end;
end;

end.
