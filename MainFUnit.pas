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
  FrameMostCategoryUnit, FrameMostProductsUnit;

type
  TMainF = class(TForm)
    AL1          : TActionList;
    actOpen: TAction;
    actRefresh   : TAction;
    actPrint     : TAction;
    actExport    : TAction;

    BM1          : TdxBarManager;
    BM1Bar1      : TdxBar;
    btnOpen      : TdxBarLargeButton;
    btnRefresh   : TdxBarLargeButton;
    btnPrint     : TdxBarLargeButton;
    btnExport    : TdxBarLargeButton;
    ilImages     : TImageList;

    pnlG1        : TPanel;
    pnlG2        : TPanel;

    OpenDialog   : TOpenDialog;
    PrintDialog  : TPrintDialog;
    dxBarLargeButton1: TdxBarLargeButton;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure actOpenExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
  private
    FrameMostProducts: TFrameMostProducts; //Frame instance variable end;
    FrameMostCategory: TFrameMostCategory; //Frame instance variable end;
  public
    procedure Notifier_RefreshAll;
    procedure Notifier_PrintReport;
    procedure Notifier_ExportReport(const aExportFmt:Integer);
end;

var
  MainF: TMainF;

implementation

uses
  MLDMS_CommonConstants;

{$R *.dfm}

procedure TMainF.FormCreate(Sender: TObject);
begin
  FrameMostProducts := TFrameMostProducts.Create(MainF);
  FrameMostProducts.Parent := pnlG1;

  FrameMostCategory := TFrameMostCategory.Create(MainF);
  FrameMostCategory.Parent := pnlG2;
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

end.
