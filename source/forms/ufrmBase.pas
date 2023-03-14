unit ufrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, mConnection,
  Vcl.Mask;

type
  TfrmBase = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }

    function showForm(formClass: TFormClass): Boolean;
    procedure setEditRequired(vObject: TObject);
  published
    { Published declarations }
    procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);

    // Edit Required
    procedure onEnterEditRequired(Sender: TObject);

    //Button Color Green
    procedure MouseMoveButtonColorGreen(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    procedure MouseLeaveButtonColorGreen(Sender: TObject);

    //Button Color Silver Blue
    procedure MouseMoveButtonColorSilverBlue(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    procedure MouseLeaveButtonColorSilverBlue(Sender: TObject);

    //Nav Menu Color Blue
    procedure MouseMoveNavMenuColorBlackBlue(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    procedure MouseLeaveNavMenuBlue(Sender: TObject);

    procedure MouseMoveNavMenuBtnColorBlue(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    procedure MouseLeaveNavMenuBtnBlackBlue(Sender: TObject);

    //Label Color Blue
     procedure MouseMoveLabelColorBlue(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    procedure MouseLeaveLabelColorBlue(Sender: TObject);

  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.ArredondarComponente(Componente: TWinControl;
  const Radius: SmallInt);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure TfrmBase.MouseMoveButtonColorGreen(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $0040911A;
end;

procedure TfrmBase.MouseLeaveButtonColorGreen(Sender: TObject);
begin
  if Sender is TPanel  then
    TPanel(Sender).color:= $00459B1B;
end;

procedure TfrmBase.MouseMoveButtonColorSilverBlue(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00DDD3C9;
end;

procedure TfrmBase.MouseLeaveButtonColorSilverBlue(Sender: TObject);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00E9E1DA;
end;

procedure TfrmBase.MouseMoveLabelColorBlue(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Sender is TLabel  then
  begin
    (Sender as TLabel).Font.Color:= $007A5A39;
    (Sender as TLabel).Font.Style:= [fsUnderline];
  end;
end;

procedure TfrmBase.onEnterEditRequired(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    TLabeledEdit(Sender).Color:= clWhite;
    TLabeledEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TMaskEdit) then
  begin
    TMaskEdit(Sender).Color:= clWhite;
    TMaskEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TComboBox) then
  begin
    TComboBox(Sender).Color:= clWhite;
    TComboBox(Sender).OnEnter:= nil;
  end;
end;

procedure TfrmBase.setEditRequired(vObject: TObject);
begin
  if (vObject is TLabeledEdit) then
  begin
    TLabeledEdit(vObject).Color:= $00AAAAFF;
    TLabeledEdit(vObject).OnEnter:= onEnterEditRequired;
  end
  else if (vObject is TMaskEdit) then
  begin
    TMaskEdit(vObject).Color:= $00AAAAFF;
    TMaskEdit(vObject).OnEnter:= onEnterEditRequired;
  end
  else if (vObject is TComboBox) then
  begin
    TComboBox(vObject).Color:= $00AAAAFF;
    TComboBox(vObject).OnEnter:= onEnterEditRequired;
  end;
end;

function TfrmBase.showForm(formClass: TFormClass): Boolean;
var
  vForm: TForm;
begin
  try
    vForm:= formClass.Create(nil);
    vForm.ShowModal;
  finally
    Result:= vForm.Tag > 0;
    FreeAndNil(vForm);
  end;
end;

procedure TfrmBase.MouseLeaveLabelColorBlue(Sender: TObject);
begin
  if Sender is TLabel  then
  begin
    (Sender as TLabel).Font.Color:= $00E98726;
    (Sender as TLabel).Font.Style:= [];
  end;
end;

procedure TfrmBase.MouseMoveNavMenuColorBlackBlue(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00CB7420;
end;

procedure TfrmBase.MouseLeaveNavMenuBlue(Sender: TObject);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00EE9D4D;
end;

procedure TfrmBase.MouseMoveNavMenuBtnColorBlue(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00EE9D4D;
end;

procedure TfrmBase.MouseLeaveNavMenuBtnBlackBlue(Sender: TObject);
begin
  if Sender is TPanel  then
    (Sender as TPanel).Color:= $00CB7420;
end;

initialization
  TConnection.GetInstance();

end.
