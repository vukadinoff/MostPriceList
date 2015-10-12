program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostCategoryUnit in 'FrameMostCategoryUnit.pas' {FrameMostCategory: TFrame},
  ExchangeRatesFUnit in 'ExchangeRatesFUnit.pas' {ExchangeRatesF},
  MLDMS_CommonExportsUnit in 'Units\MLDMS_CommonExportsUnit.pas',
  FrameMostProductsUnit in 'FrameMostProductsUnit.pas' {FrameMostProducts: TFrame};
  //DataUnit in 'DataUnit.pas' {DataUnitF};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TExchangeRatesF, ExchangeRatesF);
  //Application.CreateForm(TDataUnitF, DataUnitF);
  Application.Run;
end.
