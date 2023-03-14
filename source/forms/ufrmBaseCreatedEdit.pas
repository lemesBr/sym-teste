unit ufrmBaseCreatedEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmBaseCreatedEdit = class(TfrmBase)
    pnl_Base: TPanel;
    pnl_BtnCancell: TPanel;
    pnl_BtnSave: TPanel;
    lbl_TitleForm: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure pnl_BtnCancellClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBaseCreatedEdit: TfrmBaseCreatedEdit;

implementation

{$R *.dfm}

procedure TfrmBaseCreatedEdit.FormShow(Sender: TObject);
begin
  ArredondarComponente(pnl_BtnSave, 5);
  ArredondarComponente(pnl_BtnCancell, 5);
end;

procedure TfrmBaseCreatedEdit.pnl_BtnCancellClick(Sender: TObject);
begin
  close;
end;

end.
