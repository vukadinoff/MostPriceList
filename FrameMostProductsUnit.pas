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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCurrencyEdit;

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
    procedure RefreshProducts(const CategoryID:Integer;const Rate:Double);
    procedure Print(CurrentCategory:string);
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

procedure TFrameMostProducts.Print(CurrentCategory: string);
begin
//
end;

procedure TFrameMostProducts.RefreshProducts(const CategoryID:Integer;const Rate:Double);
const
  lcSQL=  'SELECT p.id AS ProductID,                            '+CRLF+
	        'p.name AS ProductName,                               '+CRLF+
	        '(p.price_1) AS Price1,                          '+CRLF+
	        '(p.price_1)*(1.2) AS Price1VAT,                 '+CRLF+
	        '(p.price_2) AS Price2,                          '+CRLF+
	        '(p.price_2)*(1.2) AS Price2VAT,                 '+CRLF+
          'p.currency_code                                      '+CRLF+
	        'FROM Products p                                      '+CRLF+
	        'JOIN Category c ON (c.id = p.category_id);           ';
begin
  if MainF.dbMostPriceList.Connected then
  begin
    Screen.Cursor := crSQLWait;
    if (Assigned(MainF.qryRates)) then DM.CalculateCrossRates;

    qryProducts.Active:=False;
    qryProducts.SQL.Text:= lcSQL;
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
