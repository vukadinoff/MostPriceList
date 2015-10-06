program MostPriceListProject;

uses
  Forms,
  MainFUnit in 'MainFUnit.pas' {MainF},
  FrameMostPriceList in 'FrameMostPriceList.pas' {FrameMostPriceListF: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
