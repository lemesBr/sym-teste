program symTeste;

uses
  Vcl.Forms,
  ufrmBase in 'forms\ufrmBase.pas' {frmBase},
  mBase in 'models\mBase.pas',
  mConnection in 'models\mConnection.pas',
  svcLibrary in 'services\svcLibrary.pas',
  ufrmMain in 'forms\ufrmMain.pas' {frmMain},
  ufrmBaseCreatedEdit in 'forms\ufrmBaseCreatedEdit.pas' {frmBaseCreatedEdit},
  ufrmBaseList in 'forms\ufrmBaseList.pas' {frmBaseList},
  ufrmSaleList in 'forms\ufrmSaleList.pas' {frmSaleList},
  ufrmSaleCreatedEdit in 'forms\ufrmSaleCreatedEdit.pas' {frmSaleCreatedEdit},
  mBill in 'models\mBill.pas',
  mSale in 'models\mSale.pas',
  svcAuth in 'services\svcAuth.pas',
  CustomEditHelper in 'services\CustomEditHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
