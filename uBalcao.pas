unit uBalcao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,FMX.ListView.DynamicAppearance;

type
  TfrmBalcao = class(TForm)
    layTop: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Image1: TImage;
    Label1: TLabel;
    layContent: TLayout;
    ActionList1: TActionList;
    ListView1: TListView;
    layButtons: TLayout;
    Rectangle2: TRectangle;
    StyleBook1: TStyleBook;
    imgBgList: TImage;
    Rectangle3: TRectangle;
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
    GridPanelLayout1: TGridPanelLayout;
    Rectangle9: TRectangle;
    Layout17: TLayout;
    Label16: TLabel;
    Rectangle10: TRectangle;
    Layout18: TLayout;
    Label17: TLabel;
    Rectangle11: TRectangle;
    Layout19: TLayout;
    Label18: TLabel;
    Rectangle12: TRectangle;
    Layout20: TLayout;
    Label19: TLabel;
    Rectangle13: TRectangle;
    Layout21: TLayout;
    Label20: TLabel;
    Layout22: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout5: TLayout;
    btnAddProd: TSpeedButton;
    recAddProd: TRectangle;
    lblAddProd: TLabel;
    Layout6: TLayout;
    btncancelar: TSpeedButton;
    recCancelar: TRectangle;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddProdClick(Sender: TObject);
    procedure ListView1Resize(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
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

function GetAppearanceTextObject(AListView: TListView; const AName: string): TTextObjectAppearance;
var
  DynApp: TDynamicAppearance;
  AppObj: TCollectionItem;
begin
  Result := nil;
  if AListView.ItemAppearance.ItemAppearance = 'DynamicAppearance' then
  begin
    DynApp := TDynamicAppearance(AListView.ItemAppearanceObjects.ItemObjects);
    for AppObj in DynApp.ObjectsCollection do
      if (AppObj is TAppearanceObjectItem) and
         (TAppearanceObjectItem(AppObj).AppearanceObjectName = AName) and
         (TAppearanceObjectItem(AppObj).Appearance is TTextObjectAppearance) then
      begin
        Result := TTextObjectAppearance(TAppearanceObjectItem(AppObj).Appearance);
        Break;
      end;
  end;
end;

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



procedure TfrmBalcao.ListView1Resize(Sender: TObject);
begin
   if ListView1.Width <= 0 then Exit;
      ListView1.BeginUpdate;
      ListView1.EndUpdate;
end;



procedure TfrmBalcao.ListView1UpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
  LWidth: Single;
  TDesc, TUn, TQtd, TVlUni, TVlTotal: TListItemText;
begin
  LWidth := ListView1.Width;
  if LWidth <= 0 then Exit;

  TDesc    := AItem.Objects.FindObjectT<TListItemText>('txtDesc');
  TUn      := AItem.Objects.FindObjectT<TListItemText>('txtUn');
  TQtd     := AItem.Objects.FindObjectT<TListItemText>('txtQtd');
  TVlUni   := AItem.Objects.FindObjectT<TListItemText>('txtVlUni');
  TVlTotal := AItem.Objects.FindObjectT<TListItemText>('txtVlTotal');

  if Assigned(TDesc) and Assigned(TUn) and Assigned(TQtd) and Assigned(TVlUni) and Assigned(TVlTotal) then
  begin
    TDesc.Width    := LWidth * 0.40;
    TUn.Width      := LWidth * 0.10;
    TQtd.Width     := LWidth * 0.15;
    TVlUni.Width   := LWidth * 0.15;
    TVlTotal.Width := LWidth * 0.20;

    TDesc.PlaceOffset.X    := 0;
    TUn.PlaceOffset.X      := TDesc.PlaceOffset.X + TDesc.Width;
    TQtd.PlaceOffset.X     := TUn.PlaceOffset.X + TUn.Width;
    TVlUni.PlaceOffset.X   := TQtd.PlaceOffset.X + TQtd.Width;
    TVlTotal.PlaceOffset.X := TVlUni.PlaceOffset.X + TVlUni.Width;
  end;
end;

end.
