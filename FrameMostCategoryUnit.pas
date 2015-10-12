unit FrameMostCategoryUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  mySQLDbTables, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter;

type
  TOnChangeEvent = procedure(RecordID: Integer) of object;

type
  TFrameMostCategory = class(TFrame)
    G1               : TcxGrid;
    G1V1             : TcxGridDBTableView;
    G1L1             : TcxGridLevel;
    G1V1CategoryID   : TcxGridDBColumn;
    G1V1CategoryName : TcxGridDBColumn;

    qryCategory      : TmySQLQuery;
    dsCategory       : TDataSource;

    procedure G1V1FocusedRecordChanged(Sender: TcxCustomGridTableView;
                                       APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
                                       ANewItemRecordFocusingChanged: Boolean);
  public
    function GetActiveCategoryID : Integer;
    constructor Create(AOwner:TComponent); override;
<<<<<<< HEAD
    procedure RefershCategory;
    procedure TriggerCatRecEvent(RecordID:integer);
    function GetCurrentCategoryName: string;
=======
    procedure RefreshCategory;
>>>>>>> master
  end;

implementation

{$R *.dfm}

uses
  MainFUnit;

constructor TFrameMostCategory.Create(AOwner: TComponent);
begin
  inherited;
  RefreshCategory;
end;

procedure TFrameMostCategory.RefreshCategory;
const
  lcSQL = 'SELECT id AS CategoryID, name As CategoryName ' +
          'FROM Category;                                ';
var
  qryQuery: TmySQLQuery;
begin
  qryQuery:=TmySQLQuery.Create(Self);
  qryQuery.Database:=MainF.dbMostPriceList;
  dsCategory.DataSet:=qryQuery;

  if (MainF.dbMostPriceList.Connected) then
  begin
    qryQuery.Active:=False;
    qryQuery.SQL.Text := lcSQL;
    try
      qryQuery.Open;
    finally end;
  end;
end;

function TFrameMostCategory.GetActiveCategoryID: Integer;
begin
  Result:=0;
  If ((qryCategory.Active) and (G1V1.Controller.FocusedRecord <> nil) and
      (G1V1.Controller.FocusedRecord is TcxGridDataRow)) then
    Result:=(G1V1.Controller.FocusedRecord.Values[G1V1CategoryID.Index]);
end;

procedure TFrameMostCategory.G1V1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  MainF.ActiveCategoryID:=GetActiveRecordID;
end;

function TFrameMostCategory.GetCurrentCategoryName: string;
begin
  Result:='';
  If(qryCategory.Active)and(G1V1.Controller.FocusedRecord <> nil)and(G1V1.Controller.FocusedRecord is TcxGridDataRow)then
    Result:=(G1V1.Controller.FocusedRecord.Values[G1V1CategoryName.Index]);
end;
end.
