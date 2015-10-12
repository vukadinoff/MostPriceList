unit FrameMostProductsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, cxCurrencyEdit, mySQLDbTables, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid;

type
  TFrameMostProducts = class(TFrame)
    G1              : TcxGrid;
    G1V1            : TcxGridDBTableView;
    G1L1            : TcxGridLevel;
    G1V1ProductID   : TcxGridDBColumn;
    G1V1ProductName : TcxGridDBColumn;
    G1V1Price1      : TcxGridDBColumn;
    G1V1Price1VAT   : TcxGridDBColumn;
    G1V1Price2      : TcxGridDBColumn;
    G1V1Price2VAT   : TcxGridDBColumn;

    dsProducts      : TDataSource;
    qryProducts     : TmySQLQuery;
  public
    constructor Create(AOwner:TComponent); override;
    procedure RefreshProducts(const ActiveCategoryID: Integer);
end;

implementation

{$R *.dfm}

uses
  MainFUnit, DataModule, MLDMS_CommonExportsUnit;

constructor TFrameMostProducts.Create(AOwner: TComponent);
begin
  inherited;
  RefreshProducts;
end;

procedure TFrameMostProducts.RefreshProducts(const ActiveCategoryID: Integer);
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
	        'INNER JOIN Category c                                                                      ' +
          '       ON (c.id = p.category_id)                                                           ' +
          'WHERE (p.category_id = %d);                                                                ';
var
  lvsReportCurrency: string;
begin
  if (MainF.dbMostPriceList.Connected) then
  begin
    Screen.Cursor := crSQLWait;
    if (Assigned(MainF.qryRates)) then
      DM.CalculateCrossRates;

    lvsReportCurrency:='''/' + MainF.cbCurrency.Text + '''';
    qryProducts.SQL.Text:= Format(lcSQL, [lvsReportCurrency, lvsReportCurrency,
                                          lvsReportCurrency, lvsReportCurrency,
                                          ActiveCategoryID]);
    try
      qryProducts.Active:= True;
    finally end;

    Screen.Cursor := crDefault;
  end;
end;

end.
