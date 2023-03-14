unit ufrmBaseList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, svcLibrary, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmBaseList = class(TfrmBase)
    Label1: TLabel;
    pnl_Base: TPanel;
    pnl_BtnaDD: TPanel;
    edt_Search: TLabeledEdit;
    DBGrid: TDBGrid;
    fdmt_Base: TFDMemTable;
    ds_Base: TDataSource;
    pnl_BtnActions: TPanel;
    pnl_Acoes: TPanel;
    pnl_BtnVendasOrcamentos: TPanel;
    Panel3: TPanel;
    pnl_BtnEdit: TPanel;
    TimerHoverBtnActions: TTimer;
    procedure FormShow(Sender: TObject);
    procedure pnl_BtnaDDClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edt_SearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerHoverBtnActionsTimer(Sender: TObject);
    procedure pnl_BtnActionsMouseLeave(Sender: TObject);
    procedure pnl_BtnActionsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnl_AcoesMouseLeave(Sender: TObject);
    procedure pnl_AcoesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnl_BtnEditMouseLeave(Sender: TObject);
    procedure pnl_BtnEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnl_BtnVendasOrcamentosMouseLeave(Sender: TObject);
    procedure pnl_BtnVendasOrcamentosMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure pnl_BtnEditClick(Sender: TObject);
  private
    { Private declarations }

    actionsBtnHover: boolean;
  public
    { Public declarations }
    createdFormClass: TFormClass;
    procedure list(search: string); virtual; abstract;
  end;

var
  frmBaseList: TfrmBaseList;

implementation

{$R *.dfm}

procedure TfrmBaseList.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;
  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;
  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TfrmBaseList.edt_SearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_Base.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_Base.Next;
      Key:= 35;
    end;
  end;
end;

procedure TfrmBaseList.FormShow(Sender: TObject);
begin
  inherited;
  ArredondarComponente(pnl_BtnaDD, 5);
  ArredondarComponente(pnl_BtnActions, 5);
  ArredondarComponente(pnl_Acoes, 5);
end;

procedure TfrmBaseList.pnl_AcoesMouseLeave(Sender: TObject);
begin
  inherited;
  TimerHoverBtnActions.Enabled:= True;
end;

procedure TfrmBaseList.pnl_AcoesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  TimerHoverBtnActions.Enabled:= false;
end;

procedure TfrmBaseList.pnl_BtnActionsMouseLeave(Sender: TObject);
begin
  inherited;
  actionsBtnHover:= True;
  TimerHoverBtnActions.Enabled:= true;
end;

procedure TfrmBaseList.pnl_BtnActionsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseMoveNavMenuColorBlackBlue(Sender, Shift, X, Y);
  TimerHoverBtnActions.Enabled:= false;
  pnl_Acoes.Visible:= true;
  pnl_Acoes.Left:= pnl_BtnActions.Left - 80;
  pnl_Acoes.Top:= 56;
end;

procedure TfrmBaseList.pnl_BtnaDDClick(Sender: TObject);
begin
  TLibrary.showForm(createdFormClass);
  list('');
end;

procedure TfrmBaseList.pnl_BtnEditClick(Sender: TObject);
begin
  inherited;
  if fdmt_Base.RecordCount <= 0 then
    exit;

  TLibrary.showForm(createdFormClass);
  list('');
end;

procedure TfrmBaseList.pnl_BtnEditMouseLeave(Sender: TObject);
begin
  pnl_AcoesMouseLeave(Sender);
  MouseLeaveNavMenuBtnBlackBlue(Sender);
end;

procedure TfrmBaseList.pnl_BtnEditMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  pnl_AcoesMouseMove(Sender, Shift, X, Y);
  MouseMoveNavMenuBtnColorBlue(Sender, Shift, X, Y);
end;

procedure TfrmBaseList.pnl_BtnVendasOrcamentosMouseLeave(Sender: TObject);
begin
  pnl_AcoesMouseLeave(Sender);
  MouseLeaveNavMenuBtnBlackBlue(Sender);
end;

procedure TfrmBaseList.pnl_BtnVendasOrcamentosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnl_AcoesMouseMove(Sender, Shift, X, Y);
  MouseMoveNavMenuBtnColorBlue(Sender, Shift, X, Y);
end;

procedure TfrmBaseList.TimerHoverBtnActionsTimer(Sender: TObject);
begin
  inherited;
  if actionsBtnHover then
  begin
    pnl_Acoes.Visible:= false;
    actionsBtnHover:= False;
    TimerHoverBtnActions.Enabled:= False;
    MouseLeaveNavMenuBlue(pnl_BtnActions);
  end;
end;

end.
