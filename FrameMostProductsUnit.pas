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
  dxPScxExtEditorProducers, dxPSCore, dxPScxCommon, cxCurrencyEdit;

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
    qryProductsUpdate: TmySQLUpdateSQL;
    Printer1: TdxComponentPrinter;
    Printer1G1: TdxGridReportLink;
    G1Popup: TPopupMenu;
    N3: TMenuItem;
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent); override;
    procedure RefreshProducts(const CategoryID:Integer;const CurrCode:string;const MinValue:Double; MaxValue:Double);
    procedure Print(CurrentCategory:string);
end;

implementation

{$R *.dfm}
uses
  MainFUnit,MLDMS_CommonExportsUnit;
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
  TcxGridExportMenuGroup.CreateMenuGroup(G1Popup, N3);
end;

procedure TFrameMostProducts.Print(CurrentCategory: string);
var
 lvLabel:string;
begin
  lvLabel:= 'Категория: "'+CurrentCategory+'"';
  Printer1G1.ReportTitle.Font.Name:= 'Arial';
  Printer1G1.ReportTitle.Text:=lvLabel;
  Printer1G1.PrinterPage.PageFooter.Font.Style:= Printer1G1.PrinterPage.PageFooter.Font.Style+[fsItalic];
  Printer1G1.PrinterPage.PageFooter.LeftTitle.Text:= lvLabel;
  Printer1G1.Preview(True);
end;

procedure TFrameMostProducts.RefreshProducts(const CategoryID:Integer;const CurrCode:string;const MinValue:Double; MaxValue:Double);
const
  lcSQL=  'SELECT p.id AS ProductID,                            '+CRLF+
	        'p.name AS ProductName,                               '+CRLF+
	        'p.price_1 AS Price1,                                 '+CRLF+
	        '(p.price_1)*(1.2) AS Price1VAT,                      '+CRLF+
	        'p.price_2 AS Price2,                                 '+CRLF+
	        '(p.price_2)*(1.2) AS Price2VAT                       '+CRLF+
	        'FROM Products p                                      '+CRLF+
	        'JOIN Category c ON (c.id = p.category_id);           ';
begin
  if MainF.dbMostPriceList.Connected then
  begin
    Screen.Cursor := crSQLWait;
    qryProducts.Active:= False;
    try
      qryProducts.SQL.Text:= lcSQL;
      qryProducts.Open;

      //qryProducts.Active:= True;
      //qryProducts.Edit;

      {qryProducts.First;
      while not (qryProducts.Eof) do
      begin
        qryProducts.FieldByName('Price1').Value := 2;
        qryProducts.Next;
      end; }

      //qryProducts.Post;
    finally end;
    Screen.Cursor := crDefault;
  end
  else
    ShowMessage('Няма връзка с базата данни');
end;

end.
