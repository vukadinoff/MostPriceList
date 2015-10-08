program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostCategoryUnit in 'FrameMostCategoryUnit.pas' {FrameMostCategory: TFrame},
  FrameMostProductsUnit in 'FrameMostProductsUnit.pas' {FrameMostProducts: TFrame},
  MLDMS_CommonExportsUnit in 'Units\MLDMS_CommonExportsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
