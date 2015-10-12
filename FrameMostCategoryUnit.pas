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
   TOnChangeEvent = procedure(RecordID:integer) of object;

type
  TFrameMostCategory = class(TFrame)
    G1V1: TcxGridDBTableView;
    G1L1: TcxGridLevel;
    G1: TcxGrid;
    qryCategory: TmySQLQuery;
    dsCategory: TDataSource;
    G1V1CategoryID: TcxGridDBColumn;
    G1V1CategoryName: TcxGridDBColumn;
    procedure G1V1FocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    FOnCatRecChange  : TOnChangeEvent;
    function GetActiveRecordID: Integer;
  public
    { Public declarations }
    property OnCatRecChange : TOnChangeEvent read FOnCatRecChange write FOnCatRecChange;
    constructor Create(AOwner:TComponent); override;
    procedure RefershCategory;
    procedure TriggerCatRecEvent(RecordID:integer);
    function GetCurrentCategoryName: string;
  end;

implementation

{$R *.dfm}
uses
  MainFUnit,FrameMostProductsUnit;

constructor TFrameMostCategory.Create(AOwner: TComponent);
begin
  inherited;
  qryCategory.Database := MainF.dbMostPriceList;
  dsCategory.DataSet:= qryCategory;
  G1V1.DataController.DataSource := dsCategory;
  G1V1.DataController.DetailKeyFieldNames:= 'CategoryID';
  G1V1.OptionsView.ColumnAutoWidth:= True;

  RefershCategory;
end;

procedure TFrameMostCategory.RefershCategory;
const
  lcSQL = 'SELECT id AS CategoryID, Name As CategoryName from Category';
begin
  if MainF.dbMostPriceList.Connected then
  begin
    try
      qryCategory.Active:= False;
      qryCategory.SQL.Text := lcSQL;
      qryCategory.Active:= True;
    finally

    end;
  end
  else
    ShowMessage('���� ������ � ������ �����');
end;

function TFrameMostCategory.GetActiveRecordID: Integer;
begin
  Result:=0;
  If(qryCategory.Active)and(G1V1.Controller.FocusedRecord <> nil)and(G1V1.Controller.FocusedRecord is TcxGridDataRow)then
    Result:=(G1V1.Controller.FocusedRecord.Values[G1V1CategoryID.Index]);
end;

procedure TFrameMostCategory.G1V1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  //FrameMostProducts.RefreshProducts(GetActiveRecordID,1.5);
  //send message to main form
  TriggerCatRecEvent(GetActiveRecordID);
end;

procedure TFrameMostCategory.TriggerCatRecEvent(RecordID:integer);
begin
    if Assigned(FOnCatRecChange) then
      FOnCatRecChange(RecordID);
end;

function TFrameMostCategory.GetCurrentCategoryName: string;
begin
  Result:='';
  If(qryCategory.Active)and(G1V1.Controller.FocusedRecord <> nil)and(G1V1.Controller.FocusedRecord is TcxGridDataRow)then
    Result:=(G1V1.Controller.FocusedRecord.Values[G1V1CategoryName.Index]);
end;
end.
