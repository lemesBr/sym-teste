unit CustomEditHelper;
interface
uses Vcl.StdCtrls, System.SysUtils, Vcl.ExtCtrls, System.Classes;
type
  TCustomEditHelper = class helper for TCustomEdit
  private
    procedure EditFloatKeyPress(Sender: TObject; var Key: Char);
    procedure EditFloatOnExit(Sender: TObject);
  public
    procedure EditFloat;
    procedure EditFloatExit;
  end;
implementation
uses
  svcLibrary;
{ TCustomEditHelper }
procedure TCustomEditHelper.EditFloatExit;
begin
  Self.Alignment:= taRightJustify;
  if (Self is TEdit) then
  begin
    (Self as TEdit).OnExit:= EditFloatOnExit;
  end
  else if (Self is TLabeledEdit) then
  begin
    (Self as TLabeledEdit).OnExit:= EditFloatOnExit;
  end;
  case self.Tag of
    0:Self.Text:= '0,00';
    1:Self.Text:= '0,000';
  end;
end;

procedure TCustomEditHelper.EditFloatKeyPress(Sender: TObject; var Key: Char);
var
  stringValue: string;
begin
  if Self.ReadOnly then Exit();
  if CharInSet(Key,['0'..'9',#8]) then
  begin
    stringValue:= Trim((Sender as TCustomEdit).Text);
    if (stringValue = EmptyStr) then
    begin
      case Self.Tag of
        0: stringValue:= '0,00';
        1: stringValue:= '0,000';
      end;
    end;
    if (Key = #8) then stringValue:= Copy(stringValue, 1, stringValue.Length - 1)
    else stringValue:= stringValue + Key;
    stringValue:= TLibrary.ReturnsInteger(stringValue);
    case Self.Tag of
        0: begin
          stringValue:= Copy(stringValue, 1, stringValue.Length - 2) + ',' + Copy(stringValue, stringValue.Length - 1);
          (Sender as TCustomEdit).Text:= FormatFloat('###,##0.00', StrToFloatDef(stringValue,0));
        end;
        1: begin
          stringValue:= Copy(stringValue, 1, stringValue.Length - 3) + ',' + Copy(stringValue, stringValue.Length - 2);
          (Sender as TCustomEdit).Text:= FormatFloat('###,###0.000', StrToFloatDef(stringValue,0));
        end;
      end;
  end;
  if (Key = '-') then
  begin
    stringValue:= Trim((Sender as TCustomEdit).Text);
    if Pos(Key, stringValue) = 0 then
    (Sender as TCustomEdit).Text:= Key + stringValue;
  end;
  Key:= #0;
end;
procedure TCustomEditHelper.EditFloatOnExit(Sender: TObject);
var
  stringValue: string;
begin
  stringValue:= Trim((Sender as TCustomEdit).Text);

  case Self.Tag of
    0: begin
      (Sender as TCustomEdit).Text:= FormatFloat('###,##0.00', StrToFloatDef(stringValue,0));
    end;
    1: begin
      (Sender as TCustomEdit).Text:= FormatFloat('###,###0.000', StrToFloatDef(stringValue,0));
    end;
  end;
end;

procedure TCustomEditHelper.EditFloat;
begin
  Self.Alignment:= taRightJustify;
  if (Self is TEdit) then
  begin
    (Self as TEdit).OnKeyPress:= EditFloatKeyPress;
  end
  else if (Self is TLabeledEdit) then
  begin
    (Self as TLabeledEdit).OnKeyPress:= EditFloatKeyPress;
  end;
  case self.Tag of
    0:Self.Text:= '0,00';
    1:Self.Text:= '0,000';
  end;
end;
end.
