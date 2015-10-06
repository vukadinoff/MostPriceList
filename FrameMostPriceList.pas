unit FrameMostPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs;

type
  TFrameMostPriceListF = class(TFrame)
  private
    { Private declarations }
  public
    procedure Notifier_RefreshAll;
    procedure Notifier_PrintReport;
		procedure Notifier_ExportReport(const aExportFmt:Integer);
end;

implementation

{$R *.dfm}

procedure TFrameMostPriceListF.Notifier_PrintReport;
// var lvLeftTitle:string;
begin
  inherited;
  //PrinterG1.ReportTitle.Text:=Format('Справка "%s"', [Self.Caption]);
  {if(FPeriodFrame1.Active)then
      lvLeftTitle:=Format('Период от %s до %s',  [FPeriodFrame1.StartPeriod_AsText, FPeriodFrame1.EndPeriod_AsText]);
  Printer1G1.PrinterPage.PageHeader.LeftTitle.Text:=lvLeftTitle;
  Printer1G1.PrinterPage.PageHeader.RightTitle.Text:='В обекти: ' + FCoffeePanel1.CheckedItemsAsText;}
//  PrinterG1.Preview();
end;

procedure TFrameMostPriceListF.Notifier_RefreshAll;
var lviOrderId: Integer;
begin
//  ExecuteQueryOrders;

//  lviOrderId := GetSelectedOrderId;
//  if (lviOrderId > -1) then
//    ExecuteQueryItems(lviOrderId)
//  else
//    G2V1.ClearItems;

end;

procedure TFrameMostPriceListF.Notifier_ExportReport(const aExportFmt: Integer);
begin
  inherited;
//  CommonExports.ExportGridTo(G1);
end;

end.
