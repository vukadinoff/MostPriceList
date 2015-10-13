program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostCategoryUnit in 'FrameMostCategoryUnit.pas' {FrameMostCategory: TFrame},
  ExchangeRatesFUnit in 'ExchangeRatesFUnit.pas' {ExchangeRatesF},
  MLDMS_CommonExportsUnit in 'Units\MLDMS_CommonExportsUnit.pas',
  FrameMostProductsUnit in 'FrameMostProductsUnit.pas' {FrameMostProducts: TFrame},
  DataModule in 'Units\DataModule.pas' {DM: TDataModule};

//DataUnit in 'DataUnit.pas' {DataUnitF};
	//DataModule in 'DataModule.pas' {DM: TDataModule};
{$R *.res}

begin
  Application.Initialize;
  //Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TExchangeRatesF, ExchangeRatesF);
  Application.CreateForm(TDM, DM);
  //Application.CreateForm(TDataUnitF, DataUnitF);
  Application.Run;
end.
