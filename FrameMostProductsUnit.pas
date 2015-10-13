unit FrameMostProductsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, mySQLDbTables, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, Menus, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer,
  dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, dxPScxCommon, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCurrencyEdit,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter;

type
  TFrameMostProducts = class(TFrame)
    G1              : TcxGrid;
    G1V1            : TcxGridDBTableView;
    G1L1            : TcxGridLevel;
    dsProducts      : TDataSource;
    qryProducts     : TmySQLQuery;

    G1V1ProductID   : TcxGridDBColumn;
    G1V1ProductName : TcxGridDBColumn;
    G1V1Price1      : TcxGridDBColumn;
    G1V1Price1VAT   : TcxGridDBColumn;
    G1V1Price2      : TcxGridDBColumn;
    G1V1Price2VAT   : TcxGridDBColumn;
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent); override;
    procedure RefreshProducts;
end;

implementation

{$R *.dfm}
uses
  MainFUnit, MLDMS_CommonExportsUnit, DataModule;
{ TFrameMostProducts }
const
  CRLF     = #13#10;

constructor TFrameMostProducts.Create(AOwner: TComponent);
begin
  inherited;
  qryProducts.Database := MainF.dbMostPriceList;
  dsProducts.DataSet:= qryProducts;
  G1V1.DataController.DataSource := dsProducts;
  G1V1.DataController.DetailKeyFieldNames:= 'ProductID';
  G1V1.OptionsView.ColumnAutoWidth:= True;
end;

procedure TFrameMostProducts.RefreshProducts;
const
  lcSQL=  'SELECT p.id AS ProductID,                                                                  ' +
	        '       p.name AS ProductName,                                                              ' +
          '       p.currency_code,                                                                    ' +
	        '       (p.price_1)*(SELECT cross_rate                                                      ' +
          '                    FROM CrossRates                                                        ' +
          '                    WHERE currency_pair = CONCAT(p.currency_code, %s)) AS Price1,          ' +
	        '       (p.price_1)*(SELECT cross_rate                                                      ' +
          '                    FROM CrossRates                                                        ' +
          '                    WHERE currency_pair = CONCAT(p.currency_code, %s))*(1.2) AS Price1VAT, ' +
	        '       (p.price_2)*(SELECT cross_rate                                                      ' +
          '                    FROM CrossRates                                                        ' +
          '                    WHERE currency_pair = CONCAT(p.currency_code, %s)) AS Price2,          ' +
	        '       (p.price_2)*(SELECT cross_rate                                                      ' +
          '                    FROM CrossRates                                                        ' +
          '                    WHERE currency_pair = CONCAT(p.currency_code, %s))*(1.2) AS Price2VAT  ' +
	        'FROM Products p                                                                            ' +
	        'INNER JOIN Category c ON (c.id = p.category_id);                                           ';
var
  lvsReportCurrency: string;
begin
  if MainF.dbMostPriceList.Connected then
  begin
    Screen.Cursor := crSQLWait;
    if (Assigned(MainF.qryRates)) then DM.CalculateCrossRates;

    qryProducts.Active:=False;
    lvsReportCurrency:='''/' + MainF.cbCurrency.Text + '''';
    qryProducts.SQL.Text:= Format(lcSQL, [lvsReportCurrency, lvsReportCurrency,
                                          lvsReportCurrency, lvsReportCurrency]);
    try
      qryProducts.Open;
    finally end;
    qryProducts.Active:= True;
    Screen.Cursor := crDefault;
  end
  else
    ShowMessage('Няма връзка с базата данни');
end;

end.
