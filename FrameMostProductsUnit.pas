unit FrameMostProductsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, mySQLDbTables, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

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
    procedure RefreshProducts(CategoryID,Rate:Integer);
end;

implementation

{$R *.dfm}
uses
  MainFUnit;
{ TFrameMostProducts }

constructor TFrameMostProducts.Create(AOwner: TComponent);
begin
  inherited;
  dsProducts.DataSet:= qrProducts;
  G1V1.DataController.DataSource := dsProducts;
  G1V1.DataController.DetailKeyFieldNames:= 'ProductID';
  G1V1.OptionsView.ColumnAutoWidth:= True;
end;

procedure TFrameMostProducts.RefreshProducts(CategoryID,Rate:Integer);
const
  lcSQL= 'call GetGetCatProducts (%s,%s)';
begin
  qrProducts.SQL.Text:= Format(lcSQL,[CategoryID]);
  qrProducts.ExecSQL;
end;

end.
