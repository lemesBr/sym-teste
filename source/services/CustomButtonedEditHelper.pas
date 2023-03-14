unit CustomButtonedEditHelper;

interface

uses Vcl.StdCtrls, System.SysUtils, Vcl.ExtCtrls, System.Classes, Vcl.ComCtrls, 
  Winapi.Windows, mPeople, System.Generics.Collections, svcLibrary;

type
  TCustomButtonedEditHelper = class helper for TCustomButtonedEdit
  private
    { private declarations }
    class var listView: TListView;
    class var clientList: TObjectList<TPeople>;

    procedure createListView;
    procedure searchClient(search: String);
    procedure selectClientListView;

    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RightButtonClick(Sender: TObject);

    procedure listViewClick(Sender: TObject);
    procedure listViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listViewKeyPress(Sender: TObject; var Key: Char);
  protected
    { protected declarations }
  public
    { public declarations }
    class var SelectedPeopleId: String;

    procedure setSearch;
    procedure destroyNow;
  published
    { published declarations }
  end;

implementation

{ TSearchPeople }

procedure TCustomButtonedEditHelper.createListView;
var
  ColumnName, ColumnDocument: TListColumn;
begin
  if Assigned(Self.listView) then
  begin
    Self.listView.Items.Clear;
    exit;
  end;

  Self.listView:= TListView.Create(TButtonedEdit(Self).Parent);
  with Self.listView do
  begin
    Parent:= TButtonedEdit(Self).Parent;
    Width:= 480;
    Height:= 95;
    Top:= TButtonedEdit(Self).Top + 28;
    Left:= TButtonedEdit(Self).Left;
    GridLines:= True;
    ShowColumnHeaders:= False;
    ViewStyle:= vsReport;
    OnClick:= listViewClick;
    OnKeyDown:= listViewKeyDown;
    OnKeyPress:= listViewKeyPress;
    Visible:= False;
  end;

  ColumnName:= Self.listView.Columns.Add;
  ColumnName.Caption:= 'NAME';
  ColumnName.Width:= 250;

  ColumnDocument:= Self.listView.Columns.Add;
  ColumnDocument.Caption:= 'DOCUMENT';
  ColumnDocument.Width:= 180;
end;

procedure TCustomButtonedEditHelper.destroyNow;
begin
  Self.SelectedPeopleId:= EmptyStr;
  if Assigned(listView) then FreeAndNil(listView);
  if Assigned(clientList) then FreeAndNil(clientList);
end;

procedure TCustomButtonedEditHelper.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) and (Self.listView.Visible) then
  begin
    Self.listView.Items[0].Focused := True;
    Self.listView.Items[0].Selected := True;
    Self.listView.SetFocus;
  end;
end;

procedure TCustomButtonedEditHelper.KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Self.RightButton.Visible) then
  begin
    if Self.Text = '' then
      Exit
    else
      searchClient(Self.Text);
  end;
end;

procedure TCustomButtonedEditHelper.listViewClick(Sender: TObject);
begin
  selectClientListView;
end;

procedure TCustomButtonedEditHelper.listViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not (Key in [VK_UP, VK_DOWN, VK_RETURN]) then
  begin
    Self.SetFocus;
    Self.SetSelText(Self.Text);
  end;
end;

procedure TCustomButtonedEditHelper.listViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    selectClientListView
  else
    Self.listView.SetFocus;
end;

procedure TCustomButtonedEditHelper.RightButtonClick(Sender: TObject);
begin
  Self.RightButton.Visible:= False;
  Self.ReadOnly:= False;
  Self.Text:= EmptyStr;
end;

procedure TCustomButtonedEditHelper.searchClient(search: String);
var
  tempItemClient: TListItem;
  I: Integer;
begin
  FreeAndNil(clientList);
  clientList:= TPeople.list(search);
  createListView;

  if not Assigned(clientList) then
  begin
    Self.listView.Visible:= False;
    exit;
  end;

  for I := 0 to Pred(clientList.Count) do
  begin
    tempItemClient:= Self.listView.Items.Add();
    tempItemClient.Data:= clientList[I];
    tempItemClient.Caption:= clientList[I].Name;
    if Length(clientList[I].Document) > 11 then
      tempItemClient.SubItems.Add(TLibrary.CNPJMask(clientList[I].Document))
    else
      tempItemClient.SubItems.Add(TLibrary.CPFMask(clientList[I].Document));
  end;


  Self.listView.Visible:= clientList.Count > 0;
end;

procedure TCustomButtonedEditHelper.selectClientListView;
begin
  if Self.listView.ItemIndex > -1 then
  begin
    Self.SelectedPeopleId:= TPeople(Self.listView.ItemFocused.Data).id;
    Self.text:= TPeople(Self.listView.ItemFocused.Data).Name;
    Self.listView.Visible := False;
    Self.RightButton.Visible:= True;
    Self.ReadOnly:= True;
  end;
end;

procedure TCustomButtonedEditHelper.setSearch;
begin
  if Self.SelectedPeopleId <> EmptyStr then
  begin
    Self.RightButton.Visible:= True;
    Self.ReadOnly:= True;
  end;

  (Self as TButtonedEdit).OnKeyDown:= KeyDown; 
  (Self as TButtonedEdit).OnKeyUp:= KeyUp;
  (Self as TButtonedEdit).OnRightButtonClick:= RightButtonClick;
end;

end.
