unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FireDAC.Comp.Client, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Generics.Collections, FMX.Objects, FMX.Layouts, FMX.Edit;

type
  TfrmLogin = class(TForm)
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
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}




procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin

// try
//      Request.Execute;
//
//      if Response.StatusCode = 200 then
//      begin
//        // Fecha a tela de login. Como o frmBalcao é o principal e está logo atrás,
//        // ele vai aparecer automaticamente!
//        Self.Close;
//      end
// finally
//
// end;

end;

procedure TfrmLogin.btnLoginMouseEnter(Sender: TObject);
begin
  recBtnLogin.Fill.Color := $FF33AD5E;
end;

procedure TfrmLogin.btnLoginMouseLeave(Sender: TObject);
begin
  recBtnLogin.Fill.Color := $FF1CA54C;
end;

end.
