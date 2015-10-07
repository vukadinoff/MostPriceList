unit MainFUnit;

interface

uses
  ActnList, Classes, SysUtils, DateUtils, Controls, ExtCtrls, Forms, ImgList,
  dxSkinsdxBarPainter, dxSkinsDefaultPainters, Dialogs, dxBar,
  cxClasses, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxSkinscxPCPainter, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk,
  dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxRibbonPainter, dxPSCore, dxPScxCommon, dxSkinsCore,
  FrameMostCategoryUnit, FrameMostProductsUnit, DB, mySQLDbTables;

type
  TMainF = class(TForm)
    AL1          : TActionList;
    actExit      : TAction;
    actOpen      : TAction;
    actRefresh   : TAction;
    actPrint     : TAction;
    actExport    : TAction;

    BM1          : TdxBarManager;
    BM1Bar1      : TdxBar;
    btnExit      : TdxBarLargeButton;
    btnOpen      : TdxBarLargeButton;
    btnRefresh   : TdxBarLargeButton;
    btnPrint     : TdxBarLargeButton;
    btnExport    : TdxBarLargeButton;
    ilImages     : TImageList;

    pnlG1        : TPanel;
    pnlG2        : TPanel;

    OpenDialog   : TOpenDialog;
    PrintDialog  : TPrintDialog;
    dbMostPriceList: TmySQLDatabase;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure actExitExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
  private
    FrameMostProducts: TFrameMostProducts; //Frame instance variable end;
    FrameMostCategory: TFrameMostCategory; //Frame instance variable end;
  private
    procedure InitializeDataBase;
    function OpenDatabase: Boolean;

  public
    procedure Notifier_RefreshAll;
    procedure Notifier_PrintReport;
    procedure Notifier_ExportReport(const aExportFmt:Integer);
end;

const
  gcDB_Name         = 'most_price_list';
  gcDB_Host         = '192.168.2.23';
  gcDB_Port         = 3307;
  gcDB_UserName     = 'kkroot';
  gcDB_UserPassword = 'k6415dl';

var
  MainF: TMainF;

implementation

uses
  MLDMS_CommonConstants;

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
//
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

end.
