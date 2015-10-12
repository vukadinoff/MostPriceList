program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostCategoryUnit in 'FrameMostCategoryUnit.pas' {FrameMostCategory: TFrame},
  ExchangeRatesFUnit in 'ExchangeRatesFUnit.pas' {ExchangeRatesF},
<<<<<<< HEAD
  MLDMS_CommonExportsUnit in 'Units\MLDMS_CommonExportsUnit.pas',
  FrameMostProductsUnit in 'FrameMostProductsUnit.pas' {FrameMostProducts: TFrame};
  //DataUnit in 'DataUnit.pas' {DataUnitF};
=======
  DataModule in 'Units\DataModule.pas' {DM: TDataModule},
  IOModule in 'Units\IOModule.pas';
>>>>>>> master

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TExchangeRatesF, ExchangeRatesF);
<<<<<<< HEAD
  //Application.CreateForm(TDataUnitF, DataUnitF);
=======
>>>>>>> master
  Application.Run;
end.
