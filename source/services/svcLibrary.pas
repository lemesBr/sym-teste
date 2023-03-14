unit svcLibrary;

interface

uses
  Winapi.Windows, System.SysUtils, IdHashMessageDigest, Vcl.Forms,
  Vcl.ExtCtrls, Vcl.Controls, System.IniFiles;

type
  TLibrary = class
    class function SerialDrive(Drive: string): string;
    class function MD5String(const Texto: string): string;
    class function showMessage(title, text: PWideChar; messageType: Integer): Boolean;
    class function removeCacarters(Value: string): string;
    class function ReturnsInteger(Const Value: string): string;
    class function CPFMask(Numero: string): string;
    class function CNPJMask(Numero: string): string;
    class function FONEMask(Numero: string): string;
    class function ExtendedToString(Value: Extended; Moeda: Boolean = True): string;
    class function StringToExtended(Value: string): Extended;
    class function getDelimitedText(delimited: string; var line: string): string;
    class function StrRight(S: string; vt: integer):string;
    class function StrLeft(S: string; vt: integer): string;
    class function StrCenter(S: string; vt: integer): string;
    class function TruncateValue(Value: Extended; Decimal: integer): Extended;
    class function getIniValue(vPath, vSection, vIdent: String): String;
    class procedure setIniValue(vPath, vSection, vIdent, vDefault: String);
    class procedure showForm(formClass: TFormClass);
  end;

implementation

{ TLibrary }

class function TLibrary.CNPJMask(Numero: string): string;
begin
  Result:= EmptyStr;
  if Numero.Length = 14 then
  begin
    Result:=
    Copy(Numero,1,2) +
    '.' + Copy(Numero,3,3) +
    '.' + Copy(Numero,6,3) +
    '/' + Copy(Numero,9,4) +
    '-' + Copy(Numero,13,2);
  end;
end;

class function TLibrary.CPFMask(Numero: string): string;
begin
  Result:= EmptyStr;
  if Numero.Length = 11 then
  begin
    Result:=
    Copy(Numero,1,3) +
    '.' + Copy(Numero,4,3) +
    '.' + Copy(Numero,7,3) +
    '-' + Copy(Numero,10,2);
  end;
end;

class function TLibrary.ExtendedToString(Value: Extended;
  Moeda: Boolean): string;
begin
  if (Moeda) then Result:= FormatFloat('###,##0.00', Value)
  else Result:= FormatFloat('###,###0.000', Value);
end;

class function TLibrary.FONEMask(Numero: string): string;
begin
  Result:= EmptyStr;
  case Numero.Length of
    10: begin
      Result:=
      '(' + Copy(Numero,1,2) +
      ')' + Copy(Numero,3,4) +
      '-' + Copy(Numero,7,4);
    end;
    11: begin
      Result:=
      '(' + Copy(Numero,1,2) +
      ')' + Copy(Numero,3,5) +
      '-' + Copy(Numero,8,4);
    end;
  end;
end;

class function TLibrary.getDelimitedText(delimited: string;
  var line: string): string;
var
  PosBarra: integer;
begin
  PosBarra:=Pos(delimited,line);
  Result:= StringReplace((Copy(line,1,PosBarra-1)),'[#]','|',[rfReplaceAll]);
  Delete(line,1,PosBarra);
end;

class function TLibrary.getIniValue(vPath, vSection, vIdent: String): String;
var
  vIni: TIniFile;
begin
  try
    vIni:= TIniFile.Create(vPath);
    Result:= vIni.ReadString(vSection, vIdent, '');
  finally
    FreeAndNil(vIni);
  end;
end;

class function TLibrary.MD5String(const Texto: string): string;
var
  MD5Id: TIdHashMessageDigest5;
begin
  MD5Id:= TIdHashMessageDigest5.Create;
  try
    Result:= LowerCase(MD5Id.HashStringAsHex(Texto));
  finally
    MD5Id.Free;
  end;
end;

class function TLibrary.removeCacarters(Value: string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
   X: Integer;
begin;
  for X:= 1 to Length(Value) do
  begin
    if Pos(Value[X],ComAcento) <> 0 then
      Value[X]:= SemAcento[Pos(Value[X], ComAcento)];
    Result:= Value;
  end;
end;

class function TLibrary.ReturnsInteger(const Value: string): string;
var
  I: integer;
  stringValue: string;
begin
  stringValue:= '';
  for I:= 1 To Length(Value) Do
  begin
    if CharInSet((Value[I]),['0'..'9']) then
    begin
      stringValue:= stringValue + Copy(Value, I, 1);
    end;
  end;
  result:= stringValue;
end;

class function TLibrary.SerialDrive(Drive: string): string;
var
	Serial,
	DirLen,
  Flags: DWORD;
	DirLabel: Array[0..11] of Char;
begin
  Try
    GetVolumeInformation(PChar(Drive+':\'),DirLabel,12,@Serial,DirLen,Flags,nil,0);
    Result:= IntToHex(Serial,8);
  Except
    Result:= EmptyStr;
  end;
end;

class procedure TLibrary.setIniValue(vPath, vSection, vIdent, vDefault: String);
var
  vIni: TIniFile;
begin
  try
    vIni:= TIniFile.Create(vPath);
    vIni.WriteString(vSection, vIdent, vDefault);
  finally
    FreeAndNil(vIni)
  end;
end;

class procedure TLibrary.showForm(formClass: TFormClass);
var
  vForm: TForm;
begin
  try
    vForm:= formClass.Create(nil);
    vForm.ShowModal;
  finally
    FreeAndNil(vForm);
  end;
end;

class function TLibrary.showMessage(title, text: PWideChar;
  messageType: Integer): Boolean;
begin
  Result:= True;
  case messageType of
    0: begin
      Application.MessageBox(text, Title, MB_ICONERROR+MB_OK);
    end;
    1: begin
      if Application.MessageBox(text, Title, MB_ICONINFORMATION+MB_OKCANCEL) <> IDOK then
        Result:= False;
    end;
  end;
end;

class function TLibrary.StrCenter(S: string; vt: integer): string;
Var
  X : integer;
begin
  X := StrToInt(ReturnsInteger(FloatToStr(TruncateValue((vt - Length(S)) / 2,0))));
  Result:= StringOfChar(' ',X) + S + StringOfChar(' ',X);
end;

class function TLibrary.StringToExtended(Value: string): Extended;
begin
  Value:= Trim(Value);
  Value:= StringReplace(Value, '.', '', [rfReplaceAll]);
  Result:= StrToFloatDef(Value, 0);
end;

class function TLibrary.StrLeft(S: string; vt: integer): string;
Var X : Integer;
    H : String;
begin
  H := StringOfChar(' ',vt);
  X := Length(S);
  Delete(H,1,X);
  Result := H+S ;
end;

class function TLibrary.StrRight(S: string; vt: integer): string;
Var X : Integer;
    H : String;
begin
  H := StringOfChar(' ',vt);
  X := Length(S);
  Delete(H,1,X);
  if Length(S) > vt then
    S:= Copy(S,1,vt);
  Result := S+H;
end;

class function TLibrary.TruncateValue(Value: Extended;
  Decimal: integer): Extended;
Var
  stringValue: String;
  positionNumber: Integer;
begin
  stringValue:= FloatToStr(Value);
  positionNumber:= Pos(FormatSettings.DecimalSeparator, stringValue);
  if (positionNumber > 0) then
    stringValue:= Copy(stringValue, 1, positionNumber + Decimal);
  Result:= StrToFloatDef(stringValue, 0);
end;

end.
