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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBalcao: TfrmBalcao;

implementation

{$R *.fmx}

uses uLogin;



end.
