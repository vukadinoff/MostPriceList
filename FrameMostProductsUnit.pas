unit FrameMostProductsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrameMostProducts = class(TFrame)
  private
    { Private declarations }
  public
    procedure Notifier_RefreshAll;
    procedure Notifier_PrintReport;
		procedure Notifier_ExportReport(const aExportFmt:Integer);
  end;

implementation

{$R *.dfm}

procedure TFrameMostProducts.Notifier_PrintReport;
begin
  inherited;
end;

procedure TFrameMostProducts.Notifier_RefreshAll;
begin
//
end;

procedure TFrameMostProducts.Notifier_ExportReport(const aExportFmt: Integer);
begin
  inherited;
end;

end.
