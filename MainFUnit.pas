unit MainFUnit;

interface

uses
  ActnList, Classes, SysUtils, DateUtils, Controls, ExtCtrls, Forms, ImgList,
  dxSkinsdxBarPainter, FrameMostPriceList, dxSkinsCore,
  dxSkinsDefaultPainters, dxBar, cxClasses;

type
  TMainF = class(TForm)
    AL1          : TActionList;
    actClose     : TAction;
    actRefresh   : TAction;
    actPrint     : TAction;
    actExport    : TAction;

    BM1          : TdxBarManager;
    BM1Bar1      : TdxBar;
    btnClose     : TdxBarLargeButton;
    btnRefresh   : TdxBarLargeButton;
    btnPrint     : TdxBarLargeButton;
    btnExport    : TdxBarLargeButton;
    ilImages     : TImageList;

    pnlG1G2      : TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure actCloseExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
  private
    FrameMostPriceList: TFrameMostPriceListF; //Frame instance variable end;
end;

var
  MainF: TMainF;

implementation

uses
  MLDMS_CommonConstants;

{$R *.dfm}

procedure TMainF.FormCreate(Sender: TObject);
begin
  FrameMostPriceList := TFrameMostPriceListF.Create(MainF);
  FrameMostPriceList.Parent := pnlG1G2;
end;

procedure TMainF.FormActivate(Sender: TObject);
begin
  //FrameMostPriceList.G1.SetFocus;
  //FrameMostPriceList.G1V1.DataController.FocusedRowIndex := 0;
end;

procedure TMainF.FormDestroy;
begin
  if (Assigned(FrameMostPriceList)) then
    FrameMostPriceList.Free;
end;

procedure TMainF.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainF.actRefreshExecute(Sender: TObject);
begin
  FrameMostPriceList.Notifier_RefreshAll;
end;

procedure TMainF.actPrintExecute(Sender: TObject);
begin
  FrameMostPriceList.Notifier_PrintReport;
end;

procedure TMainF.actExportExecute(Sender: TObject);
begin
  FrameMostPriceList.Notifier_ExportReport(cUnknownID);
end;

end.
