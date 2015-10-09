unit DataUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, dxmdaset;

type
  TDataUnitF = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataUnitF: TDataUnitF;

implementation

{$R *.dfm}

procedure TDataUnitF.FormCreate(Sender: TObject);
begin
  //mdCrossRates.Active := True;
  //mdCrossRates.Edit;
  //mdCrossRates.FieldValues['Price1'] := '2';
 // mdCrossRates.Post;
end;

end.
