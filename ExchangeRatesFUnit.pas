unit ExchangeRatesFUnit;

interface

uses
  Forms, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, mySQLDbTables, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, Classes,
  Controls, cxGrid;

type
  TExchangeRatesF = class(TForm)
    G1              : TcxGrid;
    G1V1            : TcxGridDBTableView;
    G1Level1        : TcxGridLevel;
    G1V1code        : TcxGridDBColumn;
    G1V1currency    : TcxGridDBColumn;
    G1V1rate        : TcxGridDBColumn;

    dsDataSource    : TDataSource;
    tblExchangeRates: TmySQLTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExchangeRatesF: TExchangeRatesF;

implementation

uses
  LocalizeDevExpressUnit;

{$R *.dfm}

initialization
  Setup_QuantumGridsResources;

end.
