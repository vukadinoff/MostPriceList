unit FrameMostProductsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, mySQLDbTables, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter;

type
  TFrameMostProducts = class(TFrame)
    G1V1: TcxGridDBTableView;
    G1L1: TcxGridLevel;
    G1: TcxGrid;
    dsProducts: TDataSource;
    qrProducts: TmySQLQuery;
    G1V1ProductID: TcxGridDBColumn;
    G1V1ProductName: TcxGridDBColumn;
    G1V1Price1: TcxGridDBColumn;
    G1V1Price2: TcxGridDBColumn;
    G1V1Price2lv: TcxGridDBColumn;
    G1V1Price2lvDDS: TcxGridDBColumn;
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent); override;
    procedure RefreshProducts(const CategoryID:Integer;const Rate:Extended);
end;

implementation

{$R *.dfm}
uses
  MainFUnit;
{ TFrameMostProducts }
const
  CRLF     = #13#10;

constructor TFrameMostProducts.Create(AOwner: TComponent);
begin
  inherited;
  qrProducts.Database := MainF.dbMostPriceList;
  dsProducts.DataSet:= qrProducts;
  G1V1.DataController.DataSource := dsProducts;
  G1V1.DataController.DetailKeyFieldNames:= 'ProductID';
  G1V1.OptionsView.ColumnAutoWidth:= True;

  RefreshProducts(1,1.5);
end;

procedure TFrameMostProducts.RefreshProducts(const CategoryID:Integer;const Rate:Extended);
const
  lcSQL=  'SELECT p.id AS ProductID,                            '+CRLF+
	        'p.name AS ProductName,                               '+CRLF+
	        'p.price_1 AS Price1,                                 '+CRLF+
	        'p.price_2 AS Price2,                                 '+CRLF+
	        'p.price_2*%1:n AS Price2lv,                          '+CRLF+
	        'p.price_2*%1:n+(p.price_2*%1:n*0.2) AS Price2lvDDS   '+CRLF+
	        'FROM Products p                                      '+CRLF+
	        'JOIN Category c ON (c.id = p.category_id)            '+CRLF+
	        'WHERE c.id = %0:d;                                   ';
begin
  if MainF.dbMostPriceList.Connected then
  begin
    Try
      qrProducts.Active:= False;
      qrProducts.SQL.Text:= Format(lcSQL,[CategoryID,Rate]);
      qrProducts.Active:= True;
    finally
    end;
  end
  else
    ShowMessage('Няма връзка с базата данни');
end;

end.
