unit MainFUnit;

interface

uses
  ActnList, Classes, SysUtils, StrUtils, DateUtils, Controls, ExtCtrls, Forms, ImgList,
  dxSkinsdxBarPainter, dxSkinsDefaultPainters, Dialogs, dxBar,
  cxClasses, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxSkinscxPCPainter, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk,
  dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxRibbonPainter, dxPSCore, dxPScxCommon, dxSkinsCore,
  FrameMostCategoryUnit, FrameMostProductsUnit, DB, mySQLDbTables,
  xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc, FMTBcd, SqlExpr,
  MegalanMySQLConnectionUnit, MySQLBatch, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxSplitter;

type
  TMainF = class(TForm)
    dbMostPriceList: TmySQLDatabase;
    AL1            : TActionList;
    actExit        : TAction;
    actOpen        : TAction;
    actRefresh     : TAction;
    actPrint       : TAction;
    actExport      : TAction;

    BM1            : TdxBarManager;
    BM1Bar1        : TdxBar;
    btnExit        : TdxBarLargeButton;
    btnOpen        : TdxBarLargeButton;
    btnRefresh     : TdxBarLargeButton;
    btnPrint       : TdxBarLargeButton;
    btnExport      : TdxBarLargeButton;
    ilImages       : TImageList;

    pnlG1          : TPanel;
    pnlG2          : TPanel;

    OpenDialog     : TOpenDialog;
    PrintDialog    : TPrintDialog;
    XMLDocument    : TXMLDocument;
    btnRates: TdxBarLargeButton;
    actRates: TAction;
    Panel2: TPanel;
    cbCurrency: TComboBox;
    lblComboBoxCurrency: TLabel;
    cxSplitter1: TcxSplitter;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure actExitExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actRatesExecute(Sender: TObject);
  private
    FrameMostProducts: TFrameMostProducts; //Frame instance variable end;
    FrameMostCategory: TFrameMostCategory; //Frame instance variable end;
  private
    procedure InitializeDataBase;
    function OpenDatabase: Boolean;
  private
    procedure myQueryExecute(aSQL: string);
    procedure DropTablesFromDB;
    procedure CreateTablesInDB;
    procedure GetXMLData(fileName: TFileName);
  public
    procedure Notifier_RefreshAll;
    procedure Notifier_PrintReport;
    procedure Notifier_ExportReport(const aExportFmt:Integer);
  public
    procedure CatRecChange(RecordID:integer);
end;

const
  gcDB_Name         = 'most_price_list';
  gcDB_Host         = 'devdb.maniapc.org';
  gcDB_Port         = 3307;
  gcDB_UserName     = 'kkroot';
  gcDB_UserPassword = 'k6415dl';

  gcDefaultXMLPath  = 'D:\MostPriceList';

var
  MainF: TMainF;

implementation

uses
  MLDMS_CommonConstants, ExchangeRatesFUnit;

{$R *.dfm}

procedure TMainF.FormCreate(Sender: TObject);
begin
  if not (OpenDatabase) then
    Exit;// If Open Database process fail then application terminate

  FrameMostCategory := TFrameMostCategory.Create(MainF);
  FrameMostCategory.Parent := pnlG1;
  FrameMostCategory.Align := alClient;

  FrameMostProducts := TFrameMostProducts.Create(MainF);
  FrameMostProducts.Parent := pnlG2;
  FrameMostProducts.Align := alClient;

  FrameMostCategory.OnCatRecChange:= MainF.CatRecChange;
  FrameMostCategory.TriggerCatRecEvent(1);
end;

procedure TMainF.FormActivate(Sender: TObject);
begin
  //FrameMostPriceList.G1.SetFocus;
  //FrameMostPriceList.G1V1.DataController.FocusedRowIndex := 0;
end;

procedure TMainF.FormDestroy;
begin
  if (Assigned(FrameMostProducts)) then
    FrameMostProducts.Free;
  if (Assigned(FrameMostCategory)) then
    FrameMostCategory.Free;
  if Assigned(dbMostPriceList)then
    dbMostPriceList.Free;
end;

procedure TMainF.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainF.actOpenExecute(Sender: TObject);
begin
  OpenDialog.InitialDir := gcDefaultXMLPath;
  If(OpenDialog.Execute)then
  begin
    DropTablesFromDB;
    CreateTablesInDB;
    GetXMLData(OpenDialog.FileName);
  end;
end;

procedure TMainF.actRatesExecute(Sender: TObject);
begin
  ExchangeRatesF.ShowModal;
end;

procedure TMainF.actRefreshExecute(Sender: TObject);
begin
  Notifier_RefreshAll;
end;

procedure TMainF.actPrintExecute(Sender: TObject);
begin
  Notifier_PrintReport;
end;

procedure TMainF.actExportExecute(Sender: TObject);
begin
  Notifier_ExportReport(cUnknownID);
end;

procedure TMainF.Notifier_PrintReport;
begin
  inherited;
end;

procedure TMainF.Notifier_RefreshAll;
begin
//
end;

procedure TMainF.Notifier_ExportReport(const aExportFmt: Integer);
begin
  inherited;
end;

procedure TMainF.InitializeDataBase;
begin
  dbMostPriceList.DatabaseName := gcDB_Name;
  dbMostPriceList.Host         := gcDB_Host;
  dbMostPriceList.Port         := gcDB_Port;
  dbMostPriceList.UserName     := gcDB_UserName;
  dbMostPriceList.UserPassword := gcDB_UserPassword;
end;

function TMainF.OpenDatabase: Boolean;
begin
  InitializeDataBase;
  try
    dbMostPriceList.Open;
    Result := dbMostPriceList.Connected;
  finally end;
end;

procedure TMainF.myQueryExecute(aSQL: string);
var
  myQuery: TmySQLQuery;
begin
  myQuery := TmySQLQuery.Create(Self);
	with myQuery do
  begin
    Screen.Cursor := crSQLWait;
    try
		  Database := dbMostPriceList;

      SQL.Text := aSQL;
      ExecSQL;
	  except
		  FreeAndNil(myQuery);
		  raise;
    end;
    Screen.Cursor := crDefault;
  end;

end;

procedure TMainF.DropTablesFromDB;
const
  lcDropTableCategory = 'DROP TABLE IF EXISTS Category;';
  lcDropTableProducts = 'DROP TABLE IF EXISTS Products;';
begin
  myQueryExecute(lcDropTableCategory);
  myQueryExecute(lcDropTableProducts);
end;

procedure TMainF.CreateTablesInDB;
const
  lcCreateTableCategory = 'CREATE TABLE Category (                  ' +
                          '  id INT(10) UNSIGNED NOT NULL,          ' +
                          '  name VARCHAR(50) NOT NULL,             ' +
                          '  PRIMARY KEY (id)                       ' +
                          ');                                       ';

  lcCreateTableProducts = 'CREATE TABLE Products (                  ' +
                          '  id int(10) unsigned NOT NULL,          ' +
                          '  category_id int(10) unsigned NOT NULL, ' +
                          '  name varchar(100) NOT NULL,            ' +
                          '  price_1 VARCHAR(50) NOT NULL,          ' +
                          '  price_2 VARCHAR(50) NOT NULL,          ' +
                          '  PRIMARY KEY (id)                       ' +
                          ');                                       ';
begin
  myQueryExecute(lcCreateTableCategory);
  myQueryExecute(lcCreateTableProducts);
end;

procedure TMainF.GetXMLData(fileName: TFileName);
var
  lvNode                : IXMLNode;
  lvsInsertCategoryData : WideString;
  lvsInsertProductData  : WideString;
  StringList            : TStringList;
  lvsCurrentCategoryName: WideString;
  lviCurrentCategoryID  : Integer;
begin
  XMLDocument.FileName := fileName;
  XMLDocument.Active := True;
  StringList := TStringList.Create;

  if not (XMLDocument.IsEmptyDoc) then
  begin
    Screen.Cursor := crHourGlass;
    try
      lvNode := XMLDocument.DocumentElement.ChildNodes.FindNode('item');
      if (lvNode <> nil) then
      begin
        lvsCurrentCategoryName := lvNode.ChildNodes['Category'].Text;
        StringList.Clear;
        StringList.Add(lvsCurrentCategoryName);
        lviCurrentCategoryID := 1;
        lvsInsertCategoryData := 'INSERT INTO Category VALUES ' + '(' + IntToStr(lviCurrentCategoryID) + ', ''' + lvsCurrentCategoryName + '''), ';
        lvsInsertProductData := 'INSERT INTO Products VALUES ';

        repeat
          lvsInsertProductData := lvsInsertProductData + '(' + lvNode.ChildNodes['ProductID'].Text + ', ';
          lvsCurrentCategoryName := lvNode.ChildNodes['Category'].Text;
          if (StringList.IndexOf(lvsCurrentCategoryName) = -1) then
          begin
            StringList.Add(lvsCurrentCategoryName);
            lviCurrentCategoryID := StringList.IndexOf(lvsCurrentCategoryName) + 1;

            lvsInsertCategoryData := lvsInsertCategoryData + ' (' + IntToStr(lviCurrentCategoryID) + ', ';
            lvsInsertCategoryData := lvsInsertCategoryData + '''' + lvsCurrentCategoryName + '''), ';
          end;
          lvsInsertProductData := lvsInsertProductData + IntToStr(lviCurrentCategoryID) + ', ';
          lvsInsertProductData := lvsInsertProductData + '''' + lvNode.ChildNodes['Name'].Text + ''', ';
          lvsInsertProductData := lvsInsertProductData + '''' + lvNode.ChildNodes['Price1'].Text + ''', ';
          lvsInsertProductData := lvsInsertProductData + '''' + lvNode.ChildNodes['Price2'].Text + '''), ';

          lvNode := lvNode.NextSibling;
        until (lvNode = nil);

        lvsInsertProductData := LeftStr(lvsInsertProductData, Length(lvsInsertProductData) - 2) + ';';
        lvsInsertCategoryData := LeftStr(lvsInsertCategoryData, Length(lvsInsertCategoryData) - 2) + ';';
      end;
    finally
      XMLDocument.Active := False;
      Screen.Cursor := crDefault;
    end;

    myQueryExecute(lvsInsertProductData);
    myQueryExecute(lvsInsertCategoryData);
  end;
end;

procedure TMainF.CatRecChange(RecordID: integer);
begin
  FrameMostProducts.RefreshProducts(RecordID,1);
end;

end.
