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
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    Rectangle3: TRectangle;
    Image3: TImage;
    Edit2: TEdit;
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
begin
  ShowMessage('Danilo');
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
