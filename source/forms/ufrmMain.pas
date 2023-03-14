unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, svcLibrary;

type
  TfrmMain = class(TfrmBase)
    Panel2: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    pnl_NavVisaoGeral: TPanel;
    pnl_NavVendas: TPanel;
    pnl_Vendas: TPanel;
    pnl_BtnVendasOrcamentos: TPanel;
    Panel3: TPanel;
    TimerHoverVendas: TTimer;
    Panel4: TPanel;
    Image1: TImage;
    procedure TimerHoverVendasTimer(Sender: TObject);
    procedure pnl_VendasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnl_VendasMouseLeave(Sender: TObject);
    procedure pnl_NavVendasMouseLeave(Sender: TObject);
    procedure pnl_NavVendasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnl_BtnOrdensServicoMouseLeave(Sender: TObject);
    procedure pnl_BtnOrdensServicoMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure pnl_BtnVendasOrcamentosClick(Sender: TObject);
  private
    { Private declarations }
    navHoverVendas: boolean;
    navHoverFinanceiro: boolean;
    navHoverCompras: boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses ufrmSaleList;

procedure TfrmMain.pnl_BtnOrdensServicoMouseLeave(Sender: TObject);
begin
  pnl_VendasMouseLeave(Sender);
  MouseLeaveNavMenuBtnBlackBlue(Sender);
end;

procedure TfrmMain.pnl_BtnOrdensServicoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnl_VendasMouseMove(Sender, Shift, X, Y);
  MouseMoveNavMenuBtnColorBlue(Sender, Shift, X, Y);
end;

procedure TfrmMain.pnl_BtnVendasOrcamentosClick(Sender: TObject);
begin
  TLibrary.showForm(TfrmSaleList);
end;

procedure TfrmMain.pnl_NavVendasMouseLeave(Sender: TObject);
begin
  navHoverVendas:= True;
  TimerHoverVendas.Enabled:= true;
end;

procedure TfrmMain.pnl_NavVendasMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  MouseMoveNavMenuColorBlackBlue(Sender, Shift, X, Y);
  TimerHoverVendas.Enabled:= false;
  pnl_Vendas.Visible:= true;
  pnl_Vendas.Top:= 47;
  pnl_Vendas.Left:= 352;
end;

procedure TfrmMain.pnl_VendasMouseLeave(Sender: TObject);
begin
  TimerHoverVendas.Enabled:= True;
end;

procedure TfrmMain.pnl_VendasMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TimerHoverVendas.Enabled:= false;
end;

procedure TfrmMain.TimerHoverVendasTimer(Sender: TObject);
begin
  if navHoverVendas then
  begin
    pnl_Vendas.Visible:= false;
    navHoverVendas:= False;
    TimerHoverVendas.Enabled:= False;
    MouseLeaveNavMenuBlue(pnl_NavVendas);
  end;
end;

end.
