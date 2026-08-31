unit uBalcao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D;

type
  TfrmBalcao = class(TForm)
    layTop: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Image1: TImage;
    Label1: TLabel;
    layContent: TLayout;
    layCabecalhoItens: TLayout;
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
    layButtons: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    StyleBook1: TStyleBook;
    imgBgList: TImage;
    Rectangle3: TRectangle;
    btnAddProd: TSpeedButton;
    recAddProd: TRectangle;
    lblAddProd: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    btncancelar: TSpeedButton;
    recCancelar: TRectangle;
    Label7: TLabel;
    Layout7: TLayout;
    Layout1: TLayout;
    Layout4: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label8: TLabel;
    Edit1: TEdit;
    Label9: TLabel;
    ComboBox1: TComboBox;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Label10: TLabel;
    Memo1: TMemo;
    Rectangle6: TRectangle;
    Layout10: TLayout;
    Label11: TLabel;
    lblNrPedido: TLabel;
    Layout11: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout3D1: TLayout3D;
    Layout14: TLayout;
    Label13: TLabel;
    Layout15: TLayout;
    lblSubTotal: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lblTotAcrescimo: TLabel;
    lblTotDesconto: TLabel;
    Label12: TLabel;
    Rectangle7: TRectangle;
    lblTotal: TLabel;
    Layout16: TLayout;
    btnFinalizar: TSpeedButton;
    Rectangle8: TRectangle;
    lblFinalizar: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddProdClick(Sender: TObject);
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
    Item.Data['line'] := '--------------------------------------------------------------';
  finally
    ListView1.EndUpdate;
  end;
end;

procedure TfrmBalcao.btnAddProdClick(Sender: TObject);
begin
  // 1. Verifica se a tela de pesquisa já existe na memória
  if not Assigned(frmPesquisaProduto) then
    Application.CreateForm(TfrmPesquisaProduto, frmPesquisaProduto);

  // 2. Abre a tela de pesquisa por cima do balcão
  frmPesquisaProduto.Show;
  frmPesquisaProduto.EditBusca.Text := '';
  frmPesquisaProduto.ListViewResultados.Items.Clear;
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
