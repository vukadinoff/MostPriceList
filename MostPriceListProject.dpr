program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostCategoryUnit in 'FrameMostCategoryUnit.pas' {FrameMostCategory: TFrame},
  ExchangeRatesFUnit in 'ExchangeRatesFUnit.pas' {ExchangeRatesF},
  DataModule in 'Units\DataModule.pas' {DM: TDataModule},
  IOModule in 'Units\IOModule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TExchangeRatesF, ExchangeRatesF);
  Application.Run;
end.
